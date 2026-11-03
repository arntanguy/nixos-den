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
        };
      };
  };
}
