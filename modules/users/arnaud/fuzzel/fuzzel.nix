{
  den.aspects.arnaud.fuzzel = {
    description = "Fuzzel launcher";
    includes = [ ];
    homeManager =
      { config, pkgs, ... }:

      {
        home.packages = with pkgs; [
          fuzzel
        ];
        home.file.".config/fuzzel/fuzzel.ini".source = ./fuzzel.ini;
      };
  };
}
