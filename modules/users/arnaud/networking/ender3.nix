{ den, lib, ... }:
{
  den.aspects.arnaud.networking.ender3 = {
    description = "Arnaud's Ender3 network configuration";
    includes = [ ];

    nixos =
      { host }:
      let
        # FIXME parameters
        ethernetInterface = builtins.trace "ethernet interface is: ${host.ethernetInterface}" host.ethernetInterface; # globals.EthernetInterface;
        ipSuffixStr = builtins.trace "host ip suffix is: ${host.ipSuffix}" host.ipSuffix; # toString config.modules.networkmanager.profiles.lirmm-pandas.ipSuffix;
        ender3Ip = "192.168.42.32";
      in
      {
        networking.hosts = {
          "${ender3Ip}" = [ "ender3.ethernet" ];
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

        # XXX: test me
        # FIXME: figure out what ports ought to be opened instead
        networking.firewall = {
          # Allow all incoming packets from the robot's specific IP address to prevent UDP 1kHz timeouts
          extraInputRules = ''
            ip saddr ${ender3Ip} accept
          '';
        };

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
