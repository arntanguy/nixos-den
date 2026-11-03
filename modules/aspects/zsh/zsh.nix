# zsh configuration
{ den, ... }:
{
  den.aspects.zsh = {
    includes = [
      (den.batteries.user-shell "zsh")
    ];

    homeManager =
      { pkgs, ... }:
      {
        home.packages = with pkgs; [ lsd ];
        home.file.".p10k.zsh".source = ./p10k.zsh;
        programs.zsh = {
          enable = true;
          history = {
            size = 10000;
            save = 10000;
            share = true;
          };

          antidote = {
            enable = true;
            plugins = [
              # Powerlevel10k theme (fancy, fast prompt)
              "romkatv/powerlevel10k"

              # Autosuggestions as you type
              "zsh-users/zsh-autosuggestions"
              # Syntax highlighting for commands
              "zsh-users/zsh-syntax-highlighting"

              # Fast directory switching (z command)
              # Use z <pattern> to go the the most used directory using <pattern>
              "rupa/z"

              # Fuzzy tab completion
              "Aloxaf/fzf-tab"
              # Fuzzy search through command history
              "joshskidmore/zsh-fzf-history-search"

              # Oh-My-Zsh plugins
              # Git aliases and helpers
              "ohmyzsh/ohmyzsh path:plugins/git"
              # Colored man pages
              "ohmyzsh/ohmyzsh path:plugins/colored-man-pages"
              # Quickly prepend sudo to commands
              # Pres <Esc><Esc> twice to prepend sudo
              # "ohmyzsh/ohmyzsh path:plugins/sudo"
              # History management
              "ohmyzsh/ohmyzsh path:plugins/history"
              # Reminds you to use defined aliases
              "MichaelAquilina/zsh-you-should-use"
            ];
          };
          initContent = ''
            [[ -f ~/.p10k.zsh ]] && source ~/.p10k.zsh
            setopt NO_BEEP
          '';
          shellAliases = {
            grep = "grep --color=auto";
            ls = "lsd --hyperlink=auto";
            ll = "ls -l";
            la = "ls -lAtr";
            cat = "bat";
            ta = "tmux a";

            bn = "cmake -B build";
            bnb = "cmake -B build && cmake --build build";
            bb = "cmake --build build";
            bt = "cmake --build build -t test";
            bi = "cmake --build build -t install";
            da = "direnv allow";
            db = "direnv block";
            gc = "git commit -am '%'";
            gd = "git difftool";
            gst = "git status";
            gp = "git push";
            gf = "git fetch --all --prune";
            gcaf = "git commit -a --fixup";
            gcan = "git commit -a --amend --no-edit";
            gch = "git checkout";
          };
        };
      };
  };
}
