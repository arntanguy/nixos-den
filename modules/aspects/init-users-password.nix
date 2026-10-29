{
  den.aspects.init-users-password = {
    includes = [ ];

    nixos =
      { user, ... }:
      builtins.trace "set initial pwd for user ${user.name}" {
        users.users.${user.name} = {
          # Replace "yourpassword" with the desired password
          initialPassword = "${user.name}";
        };
      };
  };
}
