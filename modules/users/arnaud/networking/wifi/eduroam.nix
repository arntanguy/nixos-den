{ den, ... }:
{
  den.aspects.arnaud.networking.wifi.eduroam = {
    includes = [ ];
    nixos =
      {
        host,
        user,
        lib,
        config,
        ...
      }:
      {
        sops = lib.mkIf host.enableSecrets {
          secrets = {
            "data/networking/wifi/EDUROAM" = { };
          };
        };

        networking = lib.mkIf host.enableSecrets {
          networkmanager = {
            # Add default profiles to autoconnect
            # Note: secrets are available as files at runtime decripted by sops (in /run/secrets)
            # Set key-value pairs in secrets.yaml, and use the generated file as an environmentFiles entry for network manager. Secrets are then available as variables $SECRET_NAME in network profiles.
            ensureProfiles = {
              environmentFiles = [
                config.sops.secrets."data/networking/wifi/EDUROAM".path
              ];
              profiles = {
                eduroam = {
                  connection = {
                    id = "eduroam";
                    type = "wifi";
                    autoconnect = true;
                    autoconnect-priority = 98; # Higher number wins
                    # Restrict this profile strictly to the user ${user.name}
                    # Format: "user:<username>:"
                    permissions = "user:${user.name}:";
                  };
                  wifi = {
                    mode = "infrastructure";
                    ssid = "eduroam";
                  };
                  wifi-security = {
                    key-mgmt = "wpa-eap";
                  };
                  "802-1x" = {
                    eap = "peap";
                    identity = "$EDUROAM_USER";
                    password = "$EDUROAM_PASSWORD";
                    phase2-auth = "mschapv2";
                  };
                };
              };
            };
          };
        };
      };
  };
}
