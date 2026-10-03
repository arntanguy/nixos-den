{ den, ... }: {
  # host aspect
  den.aspects.ardell = {
    includes = [
      den.aspects.terminal-tools-base
      # LIRMM
      den.aspects.networking-panda-robots
      den.aspects.printing-idh-robcolor

      den.aspects.networking-ender3-arnaud
    ];

    # XXX: freeform
    # XXX: better format
    ipSuffix = "42";
    ethernetInterface = "eth0";

    # host NixOS configuration
    nixos =
      { pkgs, ... }:
      {
        environment.systemPackages = [ pkgs.hello ];
      };

    # host provides default home environment for its users
    provides.to-users.homeManager =
      { pkgs, ... }:
      {
        home.packages = [ pkgs.vim ];
      };
  };
}
