{ den, inputs, ... }:
let
  inherit (den.lib.policy) route;
in
{
  imports = [ inputs.treefmt-nix.flakeModule ];
  # den.classes.treefmt = { };
  # den.policies.treefmt-to-flake-parts = _: [
  #   (route {
  #     fromClass = "treefmt";
  #     intoClass = "flake-parts";
  #     path = [ "treefmt" ];
  #     adaptArgs = { config, ... }: config.allModuleArgs;
  #   })
  # ];
  # den.schema.flake-parts.includes = [ den.policies.treefmt-to-flake-parts ];

  # other inputs may be defined at a module using them.
  flake-file.inputs = {
    treefmt-nix.url = "github:numtide/treefmt-nix";
    treefmt-nix.inputs.nixpkgs.follows = "nixpkgs";
  };
}
