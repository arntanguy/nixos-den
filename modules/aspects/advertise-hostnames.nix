{ den, ... }:
{
  # Advertises hostnames as <hostname>.local
  # e.g `ping <hostname>.local` from any machine on the network should work.
  den.aspects.advertise-hostnames = {
    nixos =
      { ... }:
      {
        # 1. Enable Avahi (mDNS daemon)
        services.avahi = {
          enable = true;
          nssmdns4 = true; # Allows resolving .local names for IPv4
          nssmdns6 = true; # Allows resolving .local names for IPv6

          settings = {
            publish = {
              disable-publishing = false; # Enables publishing of services
              publish-domain = true;
              publish-workstation = true;
              publish-addresses = true;
            };
          };
        };

        # 2. Ensure UDP port 5353 (mDNS) is permitted in the firewall
        # Note: services.avahi.enable automatically opens port 5353, but you can explicitly ensure it:
        networking.firewall.allowedUDPPorts = [ 5353 ];
      };
  };
}
