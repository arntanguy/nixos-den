# Niri + wayland
{ den, ... }:
{
  den.aspects.arnaud.desktop-apps = {
    includes = [
      den.aspects.nautilus
    ];

    homeManager =
      { pkgs, ... }:
      {
        programs.firefox.enable = true;

        home.packages = with pkgs; [
          eog
        ];
      };
  };
}
