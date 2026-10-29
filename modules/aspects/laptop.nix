{ den, ... }:
{
  den.aspects.laptop = {
    nixos =
      {
        pkgs,
        ...
      }:
      {
        environment.systemPackages = [ pkgs.bzmenu ];
        hardware.bluetooth.enable = true;
        services.power-profiles-daemon.enable = true;
        services.upower.enable = true;
      };
  };
}
