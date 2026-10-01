{
  den.homes.x86_64-linux.arnaud = { };

  den.aspects.arnaud.homeManager = { pkgs, ... }: {
    programs.fish.enable = true;
    home.packages = [ pkgs.cowsay ];
  };
}
