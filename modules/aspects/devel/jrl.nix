# Developpement tools to work with the Joint Robotics Laboratory (JRL-AIST, Tsukuba) ecosystem
{ den, ... }:
{
  # User-specific terminal interfaces, CLIs, and GUIs
  den.aspects.devel.jrl = {
    includes = [
      den.aspects.devel.nix
      den.aspects.devel.github
      den.aspects.devel.docker
      den.aspects.devel.vscode
    ];

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
