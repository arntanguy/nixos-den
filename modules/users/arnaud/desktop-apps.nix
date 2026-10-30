# Niri + wayland
{ den, ... }:
{
  den.aspects.arnaud.desktop-apps = {
    includes = [
      den.aspects.nautilus
      (den.batteries.unfree [ "obsidian" ])
    ];

    homeManager =
      { pkgs, ... }:
      {
        programs.firefox.enable = true;

        home.packages = with pkgs; [
          eog
          obsidian
        ];
      };
  };
}
