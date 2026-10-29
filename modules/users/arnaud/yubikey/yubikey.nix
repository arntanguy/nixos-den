{ den, ... }:
{
  den.aspects.arnaud.yubikey = {
    includes = [ ];

    nixos =
      { lib, pkgs, ... }:
      {
        # For YubiKey
        services.pcscd.enable = true; # Smartcard mode (CCID)
        # Allow access to the YubiKey over USB
        services.udev.packages = [ pkgs.yubikey-personalization ];
        environment.systemPackages = with pkgs; [
          yubioath-flutter
          yubikey-manager # A purely command-line tool used to configure, inspect, and manage various aspects of a YubiKey (OTP, FIDO, PIV, OpenPGP apps).
          yubikey-personalization # A collection of command-line tools and libraries used for programming YubiKeys with static passwords, challenge-response secrets, and OTP modes (e.g., ykpersonalize).
          pinentry-rofi
        ];

        # Instructions on how to generate and store the keys on the YubiKey are available here:
        # https://rzetterberg.github.io/yubikey-gpg-nixos.html
        #
        # The key contains 3 private sub-keys: a signing key, an encryption key and an authentication key.
        # These private keys are non-extractable. A backup of the original certification master key is stored... somewhere hidden.
        #
        # To make it work on any machine, we use gpg-agent instead of ssh-agent.
        # Only the corresponding public key is needed. It is in hosts/common/users/arnaud/keys/yubikey.pub
        # Or on https://arntanguy.fr/yubikey.pub
        #
        # Instructions for import on another machine
        # - Install gnupg.
        # - Import the public key: gpg --import ./yubikey.pub
        # - Stop the ssh-agent, run gpg-agent
        # - (If for SSH) Ensure SSH_AUTH_SOCK points to the GPG agent: export SSH_AUTH_SOCK=$(gpgconf --list-dirs agent-ssh-socket)
        # - Plug in YubiKey.
        # - Run gpg --card-status.
        #
        # Now:
        # gpg --list-secret-keys should show the private keys on the YubiKey as 'ssb>' entries
        programs.gnupg.agent = {
          enable = true;
          enableSSHSupport = true;
          # Pick a flavor: "curses" for terminal, "qt" or "gnome3" for GUI
          pinentryPackage = pkgs.pinentry-rofi;
        };
        # Disable ssh-agent in favor of gpg-agent
        # ssh-add keeps working as usual (as long as SSH_AUTH_SOCK is set to the gpg-agent, which the gnupg module does)
        programs.ssh.startAgent = false;
      };

    homeManager =
      { pkgs, config, ... }:
      {
        home.packages = with pkgs; [
          yubioath-flutter # official YubiKey Authenticator App
        ];

        # Place yubikey.pub at ~/.ssh/yubikey.pub automatically
        home.file.".ssh/yubikey.pub".source = ./yubikey.pub;

        # Automatically import your YubiKey public key on activation/switch
        home.activation.importYubikeyPub = config.lib.dag.entryAfter [ "writeBoundary" ] ''
          # Assuming yubikey.pub is stored in your repo relative to this aspect,
          # or provide an absolute path to where it lives in your flake source tree.
          PUBKEY_PATH="${./yubikey.pub}"

          if [ -f "$PUBKEY_PATH" ]; then
            # Check if the key is already imported to avoid spamming output
            if ! ${pkgs.gnupg}/bin/gpg --list-keys "64DF9BCBF1C4E40520C8F7C22B2888B308742120" >/dev/null 2>&1; then
              echo "Importing YubiKey public key..."
              ${pkgs.gnupg}/bin/gpg --import "$PUBKEY_PATH"
            fi
            # Force GPG to query the card to link secret key stubs if YubiKey is plugged in
            ${pkgs.gnupg}/bin/gpg --card-status >/dev/null 2>&1 || true
          fi
        '';
      };
  };
}
