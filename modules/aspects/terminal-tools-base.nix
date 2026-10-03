# Tools that should most likely be included on all hosts
{
  den.aspects.terminal-tools-base = {
    nixos =
      { pkgs, ... }:
      {
        environment.systemPackages = with pkgs; [
          btop
          neovim
        ];
      };
  };
}
