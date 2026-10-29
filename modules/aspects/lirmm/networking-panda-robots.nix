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
        panda6Ip = "172.16.0.6";
        panda7Ip = "172.16.1.7";
        panda2Ip = "192.168.1.2";
        pandaGaneshIp = "172.16.0.1";
      in
      {
        networking.hosts = {
          "${panda6Ip}" = [ "panda6" ];
          "${panda7Ip}" = [ "panda7" ];
          "${panda2Ip}" = [ "panda2" ];
          "${pandaGaneshIp}" = [ "panda_ganesh" ];
        };
        networking.networkmanager.enable = true;

        # Do not let NetworkManager handle ethernet interface
        networking.networkmanager.unmanaged = [
          host.ethernetInterface
        ];

        # XXX: test me
        networking.firewall = {
          allowedTCPPorts = [
            1337
            1338
            443
          ];
          # allowedUDPPorts = [];
          # Allow all incoming packets from the robot's specific IP address to prevent UDP 1kHz timeouts
          extraInputRules = ''
            ip saddr { ${panda2Ip} ${panda6Ip} ${panda7Ip} ${pandaGaneshIp} } accept
          '';
        };

        networking = {
          interfaces.${ethernetInterface} = {
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
            ];
          };
        };
      };
  };
}
