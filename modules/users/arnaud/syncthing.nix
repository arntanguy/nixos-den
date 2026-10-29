{ den, ... }:
{
  den.aspects.arnaud.syncthing = {
    nixos =
      { ... }:
      {
        # This opens the default syncthing port 22000, discovery port 21027
        # Does not open the GUI port 8385, add it to allowedTCPPorts if you want to access the GUI from outside the host
        networking.firewall.allowedTCPPorts = [
          22000
          8385
        ];
        networking.firewall.allowedUDPPorts = [
          22000
          21027
        ];
      };

    homeManager =
      {
        host,
        user,
        config,
        lib,
        pkgs,
        ...
      }:
      let
        homeDir = config.home.homeDirectory;
        enabled = host.enableSecrets or false;
      in
      {

        sops = lib.mkIf (host.enableSecrets or false) {
          # User-level secrets managed entirely within Home Manager
          secrets = {
            "data/syncthing/password" = { };
            "data/syncthing/${host.hostName}/cert" = { };
            "data/syncthing/${host.hostName}/key" = { };
          };
        };

        # Syncthing configuration as a Home Manager service
        services.syncthing = lib.mkIf enabled {
          enable = true;

          # XXX: does not exist, what needs to be opened ?
          # openDefaultPorts = true;

          guiAddress = "0.0.0.0:8385";
          # GUI Password file managed via sops-nix (conditional on secrets being enabled)
          guiCredentials.username = "${user.name}";
          guiCredentials.passwordFile = config.sops.secrets."data/syncthing/password".path;

          # Use sops secrets for TLS certificates if provided, falling back or letting syncthing generate them when disabled
          cert = config.sops.secrets."data/syncthing/${host.hostName}/cert".path;
          key = config.sops.secrets."data/syncthing/${host.hostName}/key".path;

          # Override all settings set from the GUI. This is necessary if I don't want
          # to have changes made from the GUI apply.
          overrideDevices = true;
          overrideFolders = true;

          settings = {
            devices = {
              "syncthing.arntanguy.fr" = {
                id = "BEHCUNH-5ETNA7F-WEVMHST-7GDZXCB-2PRVVMT-ZFERPA5-6HCXBFY-A2IH7AQ"; # FIXME can i still get the certificate files used to generate it?
                addresses = [ "tcp://arntanguy.fr:22000" ]; # Replace with your peer's public IP and port
              };
              "huiting13" = {
                id = "HAIXTF7-YVE56GY-2OXWMLU-53MMVVW-QZGXI3P-GRRAYRY-P3D5N37-5OATHAP";
                # FIXME address. Can i at least have a huiting13.local hostname when on lirmm network?
              };
              "dell-precision-work" = {
                id = "XFPHYXM-XDLUS6Q-K2KVNGU-MHYNLQ4-DINLOVI-BKQXG63-EJVUJAI-KFMQVAP";
              };
            };
            folders = {
              "zotero-storage" = {
                label = "zotero-storage";
                path = "${homeDir}/Zotero/storage";
                # share with these devices
                devices = [
                  "syncthing.arntanguy.fr"
                ];
              };
              "obsidian-vault" = {
                label = "obsidian-vault";
                path = "${homeDir}/Obsidian Vault";
                # share with these devices
                devices = [
                  "syncthing.arntanguy.fr"
                ];
              };
              "core-x4-camera" = {
                label = "core-x4-camera";
                path = "${homeDir}/Sync/core-x4-camera";
                # share with these devices
                devices = [
                  "syncthing.arntanguy.fr"
                ];
              };
            };
          };
        };
      };
  };
}
