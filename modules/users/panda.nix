{ den, ... }:
{
  # user aspect
  den.aspects.panda = {
    includes = [
      den.batteries.define-user
      den.batteries.primary-user
      (den.batteries.user-shell "bash")
    ];

    nixos =
      { host, user }:
      builtins.trace "set pwd for user ${user.name}" {
        users.users.${user.name} = {
          # Replace "yourpassword" with the desired password
          initialPassword = "${user.name}";
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
