{ den, ... }:
{
  den.aspects.lirmm.networking.rhps1-robot = {
    includes = [ ];

    nixos =
      { host, lib, ... }:
      {
        networking.hosts = {
          "10.4.5.120" = [ "rhps1" ];
        };
        networking.networkmanager.enable = true;

        # Do not let NetworkManager handle ethernet interface
        networking.networkmanager.unmanaged = [
          # FIXME how to get ethernet interfaces?
          # globals.EthernetInterface
          host.ethernetInterface
        ];

        networking = {
          interfaces.${host.ethernetInterface} = {
            useDHCP = false;
            ipv4.addresses = [
              {
                address = "10.4.5.${host.ipSuffix}";
                prefixLength = 24;
              }
            ];
          };
        };
      };
  };
}
