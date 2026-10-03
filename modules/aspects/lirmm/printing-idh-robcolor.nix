{ den, lib, ... }:
{
  den.aspects.printing-idh-robcolor = {
    includes = [ ];

    nixos =
      { pkgs }:
      {
        # Enable CUPS and Avahi (for printer discovery):
        services.printing = {
          enable = true;
          drivers = with pkgs; [
            cups-filters
            cups-browsed
          ];
        };

        # avahi enables resolution of *.local hostnames
        services.avahi = {
          enable = true;
          nssmdns4 = true; # This adds mdns to /etc/nsswitch.conf for hosts
          openFirewall = true; # Optional: open mDNS port in firewall
        };

        # FIXME: This fails when the printer is not connected on boot, we need to restart the
        # printing service for it to appear
        hardware.printers = {
          # ensureDefaultPrinter = "robcolor";
          ensurePrinters = [
            {
              deviceUri = "ipp://robcolor.lirmm.fr/ipp";
              location = "work";
              name = "robcolor";
              model = "everywhere";
            }
          ];
        };
        environment.systemPackages = with pkgs; [
          wsdd # Web Service Discovery (WSD) host daemon for SMB/Samba
          # Printer
          system-config-printer
        ];
  };
};
}
