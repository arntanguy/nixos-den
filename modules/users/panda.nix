{ den, ... }:
{
  # user aspect
  den.aspects.panda = {
    includes = [
      den.batteries.define-user
    ]
    ++ (with den.aspects; [
      desktop-apps
      devel.jrl

      # user specific aspects
      # XXX for now imported from arnaud user
      arnaud.nvim
      zsh
      gnome-base # or arnaud.niri
      panda.git
    ]);

    nixos =
      { user, ... }:
      {
        users.users.${user.name} = {
          extraGroups = [
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
    provides.to-hosts.nixos = { pkgs, ... }: { };
  };
}
