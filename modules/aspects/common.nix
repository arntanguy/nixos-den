{ den, ... }:
{
  den.aspects.common = {
    includes = [
      den.aspects.init-users-password
    ];

    nixos =
      { lib, pkgs, ... }:
      {
        nix.settings.experimental-features = [
          "nix-command"
          "flakes"
        ];

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
