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
        macAddr = if builtins.hasAttr "macAddress" host then host.macAddress else ""; # config.modules.networkmanager.profiles.lirmm-pandas.macAddress;
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
