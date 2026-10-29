{
  den.aspects.arnaud.lazygit = {
    description = "A simple terminal UI for git commands, written in Go.";
    homeManager =
      {
        pkgs,
        ...
      }:

      {
        home.packages = with pkgs; [
          lazygit
        ];

        xdg.configFile."lazygit/config.yml".source = ./config.yml;
      };
  };
}
