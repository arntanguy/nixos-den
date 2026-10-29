{ den, ... }:
{
  den.aspects.arnaud.networking.wifi.home-brest = {
    includes = [ ];

    nixos =
      {
        host,
        user,
        config,
        lib,
        ...
      }:
      {

        sops = lib.mkIf host.enableSecrets {
          secrets = {
            "data/networking/wifi/HOME_BREST" = {
              sopsFile = ./wifi-secrets.yaml;
            };
          };
        };

        networking.networkmanager = {
          ensureProfiles = {
            environmentFiles = [
              config.sops.secrets."data/networking/wifi/HOME_BREST".path
            ];
            profiles = {
              home_brest = {
                connection = {
                  id = "home_brest";
                  type = "wifi";
                  autoconnect = true;
                  autoconnect-priority = 100;
                  # Restrict this profile strictly to the user 'arnaud'
                  # Format: "user:<username>:"
                  permissions = "user:${user.name}:";
                };
                wifi = {
                  mode = "infrastructure";
                  ssid = "Livebox-6C80";
                };
                wifi-security = {
                  key-mgmt = "wpa-psk";
                  psk = "$HOME_BREST_PASSWORD";
                };
              };
            };
          };
        };
      };
  };
}
