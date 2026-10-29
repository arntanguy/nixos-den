{ den, ... }:
{
  den.aspects.arnaud.sops = {
    includes = [ den.aspects.sops ];

    homeManager =
      {
        host,
        config,
        lib,
        pkgs,
        ...
      }:
      {
        home.packages = [ pkgs.sops ];

        sops = lib.mkIf (host.enableSecrets or false) {
          # Points to the user's local age key file
          age.keyFile = "${config.home.homeDirectory}/.config/sops/age/keys.txt";

          # Path to this specific user's secrets file (relative to this aspect file)
          defaultSopsFile = ./secrets.yaml;
          defaultSopsFormat = "yaml";

          # User-level secrets managed entirely within Home Manager
          secrets = {
            "data/github/NIX_GH_REPO_TOKEN" = { };
          };
        };
      };
  };
}
