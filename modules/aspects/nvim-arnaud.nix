# Arnaud's neovim configuration
{ inputs, den, ... }:
{
  den.aspects.nvim-arnaud = {
    includes = [
      (den.batteries.unfree [ "copilot-language-server" ])
    ];

    homeManager =
      { pkgs, ... }:
      {
        imports = [
          inputs.nvim-wrapper.homeModules.neovim
        ];
        wrappers.neovim.enable = true;
      };
  };

  flake-file.inputs = {
    nvim-wrapper = {
      url = "github:arntanguy/nvim-wrapper";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
}
