{ den, lib, ... }:
{
  den.aspects.networking-ender3-arnaud = {
    includes = [ ];

    nixos =
      { host }:
      let
        # FIXME parameters
        ethernetInterface = builtins.trace "ethernet interface is: ${host.ethernetInterface}" host.ethernetInterface; # globals.EthernetInterface;
        ipSuffixStr = builtins.trace "host ip suffix is: ${host.ipSuffix}" host.ipSuffix; # toString config.modules.networkmanager.profiles.lirmm-pandas.ipSuffix;
      in
      {
        networking.hosts = {
          "192.168.42.32" = [ "ender3.ethernet" ];
        };
        networking.networkmanager.enable = true;

        # Do not let NetworkManager handle ethernet interface
        networking.networkmanager.unmanaged = [
          # FIXME how to get ethernet interfaces?
          # globals.EthernetInterface
          host.ethernetInterface
        ];

        # avahi enables resolution of *.local hostnames
        services.avahi = {
          enable = true;
          nssmdns4 = true; # This adds mdns to /etc/nsswitch.conf for hosts
          openFirewall = true; # Optional: open mDNS port in firewall
        };

        # FIXME: do not disable firewall here, enable only the correct ports for the panda robots
        # networking.firewall.allowedTCPPorts = [ ... ];
        # networking.firewall.allowedUDPPorts = [ ... ];
        networking.firewall.enable = false;

        networking = {
          interfaces.${ethernetInterface} = {
            ipv4.addresses = [
              {
                # ender3 ethernet
                address = "192.168.42.${ipSuffixStr}";
                prefixLength = 24;
              }
            ];
          };
        };
      };
  };
}
