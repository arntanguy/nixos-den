# Bitwarden configuration for arnaud user
{
  den.aspects.arnaud.bitwarden = {
    includes = [ ];
    homeManager =
      { pkgs, ... }:
      {
        home.packages = with pkgs; [
          rofi-rbw-wayland
        ];
        programs.rbw = {
          enable = true;
          settings = {
            base_url = "https://vault.arntanguy.fr";
            email = "arn.tanguy@gmail.com";
            pinentry = pkgs.pinentry-rofi;
          };
        };
      };
  };
}
