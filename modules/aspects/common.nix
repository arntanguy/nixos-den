{ den, ... }:
{
  den.aspects.common = {
    includes = [
      den.batteries.hostname
      den.aspects.firmware-update
      den.aspects.init-users-password
      den.aspects.advertise-hostnames
    ];

    nixos =
      { lib, pkgs, ... }:
      {
        nix.settings.experimental-features = [
          "nix-command"
          "flakes"
        ];

        programs = {
          # Automatically creates a loader in /lib/* to avoid patching stuff
          # This allows to run most non-nix programs without patching
          # See: https://wiki.nixos.org/wiki/Nix-ld
          # Needed to run most uv packages natively
          nix-ld.enable = true;
        };

        networking.firewall = {
          enable = true;
        };

        fonts = {
          fontconfig.enable = true;
          packages = with pkgs; [
            nerd-fonts.jetbrains-mono
          ];
        };

        services.openssh = {
          enable = true;
          # Optional: allow password authentication (default is false)
          settings.PasswordAuthentication = true;
          # Optional: allow root login (default is "prohibit-password")
          # permitRootLogin = "no";
          # Optional: open the firewall for SSH
          openFirewall = true;
        };
      };

  };

}
