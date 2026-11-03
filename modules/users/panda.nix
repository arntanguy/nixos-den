{ den, ... }:
{
  # user aspect
  den.aspects.panda = {
    includes = [
      den.batteries.define-user
      den.batteries.primary-user
      (den.batteries.user-shell "bash")
    ]
      ++ (with den.aspects; [
        desktop-apps
        devel.jrl

        # user specific aspects
        # XXX for now imported from arnaud user
        arnaud.nvim
        arnaud.fish
        arnaud.niri
      ]);

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
