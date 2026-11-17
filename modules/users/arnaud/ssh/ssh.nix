{
  den.aspects.arnaud.ssh = {
    homeManager =
      {
        config,
        ...
      }:

      {
        home.file.".ssh/config" = {
          source =
            let
              actualSshConfig = "${config.home.homeDirectory}/nixos-den/modules/users/arnaud/ssh/config";
            in
            builtins.warn "ssh: creating a symlink from ~/.ssh/config to ${actualSshConfig}"
              config.lib.file.mkOutOfStoreSymlink
              "${actualSshConfig}";
          force = true;
        };
        programs.ssh = {
          enableDefaultConfig = false;
          enable = true;
        };
      };
  };
}
