{
  den.aspects.lirmm.common = {
    description = "Things that are true of all LIRMM machines";
    nixos = { pkgs, ... }: {
      time.timeZone = "Europe/Paris";
      environment.systemPackages = with pkgs; [ glpi-agent ];
    };
  };
}
