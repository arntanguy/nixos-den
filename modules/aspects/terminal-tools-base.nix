# Tools that should most likely be included on all hosts
{
  # user aspect
  den.aspects.terminal-tools-base = {
    nixos =
      { pkgs, ... }:
      {
        environment.systemPackages = [ pkgs.htop ];
      };
  };
}
