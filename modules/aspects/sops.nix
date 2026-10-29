{ den, inputs, ... }:
{
  den.aspects.sops = {
    nixos = { ... }: {
      # 1. Include the system-level sops-nix module
      imports = [ inputs.sops-nix.nixosModules.sops ];

      # 2. Automatically inject the sops-nix Home Manager module into all user profiles
      home-manager.sharedModules = [
        inputs.sops-nix.homeManagerModules.sops
      ];
    };
  };

  # other inputs may be defined at a module using them.
  flake-file.inputs = {
    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
}
