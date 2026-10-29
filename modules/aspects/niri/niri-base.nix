# Default config for
# Niri + wayland
{
  den.aspects.niri-base = {
    nixos =
      { pkgs, ... }:
      {
        programs = {
          niri.enable = true;
          xwayland.enable = true;
        };

        services = {
          displayManager.enable = true;
          displayManager.ly.enable = true;
        };

        environment.systemPackages =
          with pkgs;
          [
            xwayland
            xwayland-satellite
          ]
          ++
            # default niri configuration expects those
            # XXX why is this not pulled in by programs.niri.enable?
            [
              fuzzel
              alacritty
              swaylock
            ];

        environment.variables = {
          LD_LIBRARY_PATH = "/run/opengl-driver/lib";
          ELECTRON_OZONE_PLATFORM_HINT = "wayland";
          OZONE_PLATFORM = "wayland";
          GDK_BACKEND = "wayland";
        };
      };
  };
}
