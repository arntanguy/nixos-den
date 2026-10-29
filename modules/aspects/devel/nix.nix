# Nix developpement tools
{
  den.aspects.devel.nix = {
    homeManager =
      { pkgs, ... }:
      {
        home.packages = with pkgs; [
          # Core Nix Infrastructure
          nixfmt
          nurl # Nix fetcher code generator
          nix-tree # Dependency tree viewer
          nix-visualize
          graphviz

          # Cloud & Artifact Repositories
          cachix
          attic-client
        ];
      };
  };
}
