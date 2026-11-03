{ den, ... }:
{
  den.aspects.desktop-apps = {
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

