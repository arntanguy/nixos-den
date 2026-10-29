{ den, ... }:
{
  den.aspects.arnaud.networking.wifi.lirmm = {
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
        sops = lib.mkIf (host.enableSecrets or false) {
          # User-level secrets managed entirely within Home Manager
          secrets = {
            "data/networking/wifi/LIRMM" = {
              sopsFile = ./wifi-secrets.yaml;
            };
          };
        };

        networking = lib.mkIf (host.enableSecrets or false) {
          networkmanager = {
            # Add default profiles to autoconnect
            # Note: secrets are available as files at runtime decripted by sops (in /run/secrets)
            # Set key-value pairs in secrets.yaml, and use the generated file as an environmentFiles entry for network manager. Secrets are then available as variables $SECRET_NAME in network profiles.
            ensureProfiles = {
              environmentFiles = [
                config.sops.secrets."data/networking/wifi/LIRMM".path
              ];
              profiles = {
                LIRMM = {
                  connection = {
                    id = "LIRMM";
                    type = "wifi";
                    autoconnect = true;
                    autoconnect-priority = 99; # Higher number wins
                    # Restrict this profile strictly to the user 'arnaud'
                    # Format: "user:<username>:"
                    permissions = "user:${user.name}:";
                  };
                  wifi = {
                    mode = "infrastructure";
                    ssid = "LIRMM";
                  };
                  wifi-security = {
                    key-mgmt = "wpa-eap";
                  };
                  "802-1x" = {
                    eap = "peap";
                    identity = "$LIRMM_USER";
                    password = "$LIRMM_PASSWORD";
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
