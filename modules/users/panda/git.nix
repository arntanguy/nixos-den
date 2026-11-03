{
  den.aspects.panda.git = {
    includes = [ ];

    homeManager =
      { host, user, ... }:
      {
        programs.git = {
          enable = true;
          settings = {
            user.name = "${user.name} (${host.hostName})";
            user.email = "${user.name}@${host.hostName}.local";
            init.defaultBranch = "main";
            rerere.enable = true;
            pull.rebase = true;
            color.ui = "auto";
            # Use SSH instead of HTTPS for GitHub
            url."git@github.com:".insteadOf = "https://github.com/";
            commit.gpgSign = false;
          };
        };
      };
  };
}
