{ den, ... }:
{
  den.aspects.lirmm.common = {
    description = "Things that are true of all LIRMM machines";

    includes = [
      den.aspects.lirmm.networking.dhcp
    ];

    nixos = { pkgs, ... }: {
      time.timeZone = "Europe/Paris";
      environment.systemPackages = with pkgs; [ glpi-agent ];
    };
  };
}
