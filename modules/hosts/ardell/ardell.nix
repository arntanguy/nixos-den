{ den, ... }: {
  # host aspect
  den.aspects.ardell = {
    includes = [
      den.aspects.terminal-tools-base
      # LIRMM
      den.aspects.networking-panda-robots
      den.aspects.printing-idh-robcolor

      den.aspects.networking-ender3-arnaud
    ];

    # XXX: freeform
    # XXX: better format
    ipSuffix = "42";
    ethernetInterface = "eth0";

    # host NixOS configuration
    nixos =
      { host, pkgs, ... }:
      {
        # _ = builtins.trace "isVM" host.isVM;

        virtualisation.vmVariant = builtins.trace "vmVariant evaluated as we are running in a vm" {
          # following configuration is added only when building VM with build-vm
          # users.users.root.initialPassword = "root";
        };

        imports = [
          ./_hardware-configuration.nix
        ];

        # Bootloader
        boot.loader = {
          systemd-boot.enable = false;
          grub.enable = true;
          grub.device = "nodev";
          grub.theme = pkgs.fetchFromGitHub {
            owner = "shvchk";
            repo = "fallout-grub-theme";
            rev = "80734103d0b48d724f0928e8082b6755bd3b2078";
            sha256 = "sha256-7kvLfD6Nz4cEMrmCA9yq4enyqVyqiTkVZV5y4RyUatU=";
          };
          grub.efiSupport = true;
          grub.useOSProber = true;
          efi.canTouchEfiVariables = true;
        };
        boot = {
          kernelPackages = pkgs.linuxPackages;
          supportedFilesystems = [ "ntfs" ];
        };

        environment.systemPackages = [ pkgs.hello ];
      };

    # host provides default home environment for its users
    provides.to-users.homeManager =
      { pkgs, ... }:
      {
        home.packages = [ pkgs.vim ];
      };
  };
}
