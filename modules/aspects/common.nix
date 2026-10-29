{ den, ... }:
{
  den.aspects.common = {
    includes = [ ];

    nixos =
      { lib, ... }:
      {
        nix.settings.experimental-features = [
          "nix-command"
          "flakes"
        ];
        hardware = {
          graphics.enable = true;
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
