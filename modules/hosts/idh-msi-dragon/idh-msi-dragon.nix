{ inputs, den, ... }: {
  # host aspect
  den.aspects.idh-msi-dragon = {
    includes = [
      den.aspects.common # nix settings, openssh, init user passwords
      den.aspects.nvidia
      den.aspects.idh-msi-dragon.nvidia
      den.aspects.terminal-tools-base
      den.aspects.laptop
      # LIRMM
      den.aspects.lirmm.common
      den.aspects.lirmm.teams.idh
    ];

    # host NixOS configuration
    nixos =
      { host, pkgs, ... }:
      {
        imports = [
          inputs.disko.nixosModules.default
          ./_disk-config.nix
          ./_hardware-configuration.nix
        ];

        # Bootloader
        boot = {
          loader = {
            systemd-boot.enable = true;
            efi.canTouchEfiVariables = true;
          };
          kernelPackages = pkgs.linuxPackages; # which linux kernel to boot
          supportedFilesystems = [ "ntfs" ]; # ensure the linux kernel has ntfs support
        };
        # X11 / XKB Settings (Ly and Wayland compositors use this underlying layer)
        services.xserver.xkb = {
          layout = "fr";
          variant = ""; # optional: e.g., "nodeadkeys"
          options = "grp:win_space_toggle"; # optional: layout switching shortcuts if you have multiple
        };
        # `keymap` won't apply when prompted to enter the passphrase to decrypt on boot
        console = {
          earlySetup = true;
          useXkbConfig = true;
        };

        # Disable sleep
        # XXX: test me
        systemd.targets.sleep.enable = false;
        systemd.targets.suspend.enable = false;
        systemd.targets.hibernate.enable = false;
        systemd.targets.hybrid-sleep.enable = false;

        environment.systemPackages = [ pkgs.hello ];

      };

    # host provides default home environment for its users
    provides.to-users.homeManager =
      { pkgs, ... }:
      {
        home.packages = [ pkgs.vim ];
      };
  };
}
