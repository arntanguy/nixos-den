{
  den.aspects.arnaud.networking.wifi.android-ap = {
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
          # User-level secrets managed entirely within Home Manager
          secrets = {
            "data/networking/wifi/ARNAUD_ANDROID_AP" = {
              sopsFile = ./wifi-secrets.yaml;
            };
          };
        };

        networking = lib.mkIf host.enableSecrets {
          networkmanager = {
            # Add default profiles to autoconnect
            # Note: secrets are available as files at runtime decripted by sops (in /run/secrets)
            # Set key-value pairs in secrets.yaml, and use the generated file as an environmentFiles entry for network manager. Secrets are then available as variables $SECRET_NAME in network profiles.
            ensureProfiles = {
              environmentFiles = [
                config.sops.secrets."data/networking/wifi/ARNAUD_ANDROID_AP".path
              ];
              profiles = {
                arnaud-android-ap = {
                  connection = {
                    id = "arnaud-android-ap";
                    type = "wifi";
                    autoconnect = false;
                    autoconnect-priority = 10; # Higher number wins
                    # Restrict this profile strictly to the user '${user.name}'
                    # Format: "user:<username>:"
                    permissions = "user:${user.name}:";
                  };
                  wifi = {
                    mode = "infrastructure";
                    ssid = "arnaud";
                  };
                  wifi-security = {
                    key-mgmt = "wpa-psk";
                    psk = "$ARNAUD_ANDROID_AP_PASSWORD";
                  };
                  ipv4 = {
                    method = "auto";
                  };
                  ipv6 = {
                    method = "ignore";
                  };
                };
              };
            };
          };
        };
      };
  };
}
