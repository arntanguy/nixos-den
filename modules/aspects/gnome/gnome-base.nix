{
  den.aspects.gnome-base = {
    nixos =
      { pkgs, ... }:
      {
        programs = {
          xwayland.enable = true;
        };

        services = {
          displayManager.enable = true;
          displayManager.ly.enable = true;
          desktopManager.gnome.enable = true;

          gnome = {
            core-apps.enable = false;
            core-developer-tools.enable = false;
            games.enable = false;
          };
        };
        environment.gnome.excludePackages = with pkgs; [
          gnome-tour
          gnome-user-docs
        ];

        environment.systemPackages = with pkgs; [
          xwayland
          xwayland-satellite
        ];

        environment.variables = {
          GTK_THEME = "Adwaita"; # Set default GTK theme
          XCURSOR_THEME = "Adwaita"; # Set cursor theme
          XCURSOR_SIZE = 24; # Set cursor size (optional)
        };
      };

    homeManager = { pkgs, ... }: {
      home.pointerCursor = {
        enable = true;
        gtk.enable = true;
        package = pkgs.catppuccin-cursors.mochaSapphire; # Specify cursor theme package
        name = "catppuccin-mocha-sapphire-cursors"; # Specify cursor theme name
        size = 12; # Set cursor size
      };
    };
  };
}
