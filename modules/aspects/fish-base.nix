{ den, ... }:
{
  den.aspects.fish-base = {
    includes = [ ];

    nixos =
      { lib, pkgs, ... }:
      {
        programs.fish = {
          enable = true;
        };
      };
  };
}
