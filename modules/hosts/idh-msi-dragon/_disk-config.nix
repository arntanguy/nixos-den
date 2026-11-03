{
  disko.devices.disk.main = {
    type = "disk";
    device = "/dev/nvme0n1";
    content = {
      type = "gpt";
      partitions = {
        boot = {
          size = "1M";
          type = "EF02";
          priority = 1;
        };
        esp = {
          size = "512M";
          type = "EF00";
          content = {
            type = "filesystem";
            format = "vfat";
            mountpoint = "/boot";
            mountOptions = [ "umask=0077" ];
          };
        };
        swap = {
          size = "32G";
          content = {
            type = "swap";
          };
        };
        root = {
          size = "100%";
          content = {
            type = "lvm_pv";
            vg = "pool";
          };
        };
      };
    };
  };

  disko.devices.lvm_vg.pool = {
    type = "lvm_vg";
    lvs = {
      root = {
        size = "100%FREE";
        content = {
          type = "luks";
          name = "root";
          # Tells disko where to find the key during install
          # Usage:
          # MY_PASS=$(mktemp)
          # echo -n "your-super-secret-password" > "$MY_PASS"
          # nix run github:nix-community/nixos-anywhere -- \
          # --flake .#huiting13 \
          # --disk-encryption-keys /tmp/disk-encryption.key "$MY_PASS" \
          # root@<IP-ADDRESS-OF-HUITING13>
          passwordFile = "/tmp/disk-encryption.key";
          settings.allowDiscards = true;
          content = {
            type = "filesystem";
            format = "ext4";
            mountpoint = "/";
          };
        };
      };
    };
  };
}
