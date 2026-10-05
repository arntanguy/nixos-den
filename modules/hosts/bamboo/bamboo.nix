{ den, ... }: {
  # host aspect
  den.aspects.bamboo = {
    includes = [
      den.aspects.terminal-tools-base
      # LIRMM
      den.aspects.networking-panda-robots
    ];

    # host NixOS configuration
    nixos =
      { pkgs, ... }:
      {
        environment.systemPackages = [ pkgs.hello ];

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
      };

    # host provides default home environment for its users
    provides.to-users.homeManager =
      { pkgs, ... }:
      {
        home.packages = [ pkgs.vim ];
      };
  };
}
