# Niri + wayland
{ den, ... }:
{
  den.aspects.arnaud.desktop-apps = {
    includes = [ ];

    homeManager =
      { pkgs, ... }:
      {
        programs.firefox.enable = true;

        home.packages = with pkgs; [
          nautilus
          eog
        ];
      };
  };
}
