{ den, ... }:
{
  # user aspect
  den.aspects.guest = {
    includes = [
      den.batteries.define-user
      den.batteries.primary-user
      (den.batteries.user-shell "fish")
    ];

    nixos =
      { host, user }:
      builtins.trace "set pwd for user ${user.name}" {
        users.users.${user.name} = {
          # Replace "yourpassword" with the desired password
          password = "${user.name}";
        };
      };

    homeManager =
      { pkgs, ... }:
      {
        home.packages = [ pkgs.htop ];
      };

    # user can provide NixOS configurations
    # to any host it is included on
    provides.to-hosts.nixos = { pkgs, ... }: { };
  };
}
