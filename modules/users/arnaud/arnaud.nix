{ den, ... }:
{
  # user aspect
  den.aspects.arnaud = {
    includes = [
      den.batteries.define-user
      den.batteries.primary-user
      den.batteries.hostname
      (den.batteries.user-shell "bash")
      den.aspects.nvim-arnaud
      den.aspects.niri-arnaud

      den.aspects.git-arnaud
      den.aspects.yubikey-arnaud

      den.aspects.devel.jrl
    ];

    homeManager =
      { pkgs, ... }:
      {
        home.packages = [ ];
      };

    # user can provide NixOS configurations
    # to any host it is included on
    provides.to-hosts.nixos = { pkgs, ... }: { };
  };
}
