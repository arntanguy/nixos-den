{ den, ... }:
{
  # user aspect
  den.aspects.arnaud = {
    includes = [
      den.batteries.define-user
      den.batteries.primary-user
      den.batteries.hostname
      den.aspects.nvim-arnaud
      den.aspects.fish-arnaud
      den.aspects.niri-arnaud

      den.aspects.git-arnaud
      den.aspects.yubikey-arnaud

      den.aspects.devel.jrl
    ];

    nixos =
      { user, ... }:
      {
        users.users.${user.name} = {
          extraGroups = [
            "wheel"
            "dialout"
            "plugdev"
            "networkmanager"
            "wireshark"
            "docker"
            "input"
          ];
        };
      };

    homeManager =
      { pkgs, ... }:
      {
        home.packages = [ ];
      };

    # user can provide NixOS configurations
    # to any host it is included on
    # evaluates when the den.aspect.arnaud is listed in host's apects list
    # ex: setup ssh authorized keys, sudo rights etc on a remote server
    # TODO: investigate deeper how to use it
    provides.to-hosts.nixos = { pkgs, ... }: { };
  };
}
