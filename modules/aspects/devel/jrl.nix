# Developpement tools to work with the Joint Robotics Laboratory (JRL-AIST, Tsukuba) ecosystem
{ den, inputs, ... }:
{
  # User-specific terminal interfaces, CLIs, and GUIs
  den.aspects.devel.jrl = {
    includes = [
      den.aspects.devel.nix
      den.aspects.devel.github
      den.aspects.devel.docker
      den.aspects.devel.vscode
    ];

    nixos =
      { config, ... }:
      {
        nix = {
          # makes nix run nixpkgs#... use the same nixpkgs as the system by default
          registry.nixpkgs.flake = inputs.nixpkgs;
          settings = {
            trusted-users = [
              "root"
            ];

            substituters = [
              "https://gepetto.cachix.org"
              "https://mc-rtc-nix.cachix.org"
              "https://attic.arntanguy.fr/mc-rtc-nix-private"
              "https://attic.iid.ciirc.cvut.cz/ros"
            ];

            trusted-public-keys = [
              "gepetto.cachix.org-1:toswMl31VewC0jGkN6+gOelO2Yom0SOHzPwJMY2XiDY="
              "mc-rtc-nix.cachix.org-1:5M3sLvHXJCep4wc1tQl7QuFWL2eH2I0jkuvWtqJDYQs="
              "mc-rtc-nix-private:jXpQCG0bFJIJxAuQpHQEyRsF+PyUcvIyFmnBcR5kEuo="
              "ros:JR95vUYsShSqfA1VTYoFt1Nz6uXasm5QrcOsGry9f6Q="
            ];
          };
          extraOptions = ''
            # Ensure we can still build when missing cache server is not accessible
            fallback = true
          '';
        };
      };

    homeManager =
      { pkgs, ... }:
      {
        home.packages = with pkgs; [
          jrl-cmakemodules
          cloudsmith-cli
          pre-commit
          prek
        ];
      };
  };
}
