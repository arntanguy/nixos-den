# Tools that should most likely be included on all hosts
{ den, ... }:
{
  den.aspects.terminal-tools-base = {
    nixos =
      { pkgs, ... }:
      {
        # Set Neovim as the default system editor
        environment.variables = {
          EDITOR = "nvim";
          VISUAL = "nvim";
        };

        # Automatically create system-wide symlinks/aliases for vi and vim -> nvim
        programs.neovim = {
          enable = true;
          defaultEditor = true;
          viAlias = true;
          vimAlias = true;
        };

        # Base system packages for troubleshooting and terminal interaction
        environment.systemPackages = with pkgs; [
          # Essential text & file tools
          btop # Modern resource monitor
          wget
          curl
          git
          tmux # Terminal multiplexer for persistent sessions

          # Modern CLI tool replacements
          ripgrep # Extremely fast search (replacement for 'grep')
          fd # Simple, fast replacement for 'find'

          # System & Network diagnostics
          pciutils # lspci
          usbutils # lsusb
          dig # DNS lookup tool
        ];
      };
  };
}
