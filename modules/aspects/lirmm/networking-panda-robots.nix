{ den, ... }:
{
  den.aspects.networking-panda-robots = {
    includes = [ ];

    nixos =
      { host, lib, ... }:
      let
        # FIXME parameters
        ethernetInterface = builtins.trace "ethernet interface is: ${host.ethernetInterface}" host.ethernetInterface; # globals.EthernetInterface;
        ipSuffixStr = builtins.trace "host ip suffix is: ${host.ipSuffix}" host.ipSuffix; # toString config.modules.networkmanager.profiles.lirmm-pandas.ipSuffix;
        macAddr = if builtins.hasAttr "macAddress" host then host.macAddress else ""; # config.modules.networkmanager.profiles.lirmm-pandas.macAddress;
      in
      {
        networking.hosts = {
          "172.16.0.6" = [ "panda6" ];
          "172.16.1.7" = [ "panda7" ];
          "192.168.1.2" = [ "panda2" ];
          "172.16.0.1" = [ "panda_ganesh" ];
          "192.168.42.32" = [ "ender3.ethernet" ];
        };
        networking.networkmanager.enable = true;

        # Do not let NetworkManager handle ethernet interface
        networking.networkmanager.unmanaged = [
          # FIXME how to get ethernet interfaces?
          # globals.EthernetInterface
          host.ethernetInterface
        ];

        # FIXME: do not disable firewall here, enable only the correct ports for the panda robots
        # networking.firewall.allowedTCPPorts = [ ... ];
        # networking.firewall.allowedUDPPorts = [ ... ];
        networking.firewall.enable = false;

        networking = {
          interfaces.${ethernetInterface} = {
            # XXX: is this useful?
            mtu = 1400; # or even 1280 reduce latency
            # Set custom MAC address if specified
            macAddress = lib.mkIf (macAddr != "") macAddr;
            useDHCP = false;
            ipv4.addresses = [
              {
                address = "172.16.0.${ipSuffixStr}";
                prefixLength = 24;
              }
              {
                address = "172.16.1.${ipSuffixStr}";
                prefixLength = 24;
              }
              {
                address = "192.168.1.${ipSuffixStr}";
                prefixLength = 24;
              }
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
