{ den, ... }:
{
  den.aspects.networking-dhcp = {
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
        networking.networkmanager.enable = true;

        # Do not let NetworkManager handle ethernet interface
        networking.networkmanager.unmanaged = [
          # FIXME how to get ethernet interfaces?
          # globals.EthernetInterface
          host.ethernetInterface
        ];

        networking = {
          interfaces.${ethernetInterface} = {
            # Set custom MAC address if specified
            macAddress = lib.mkIf (macAddr != "") macAddr;
            useDHCP = true;
          };
        };
      };
  };
}
