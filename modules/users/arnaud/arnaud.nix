{ den, lib, ... }:
{
  # user aspect
  den.aspects.arnaud = { host, ... }: {
    includes =
      with den.batteries;
      [
        define-user
        primary-user
        hostname
      ]
      ++ (with den.aspects; [
        devel.jrl

        # user specific aspects
        arnaud.nvim
        arnaud.fish
        arnaud.niri
        arnaud.desktop-apps
        arnaud.git
        arnaud.yubikey
        arnaud.sops
        arnaud.syncthing
        arnaud.networking.wifi

        arnaud.networking.ender3
        arnaud.audio-editing
      ]);

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
