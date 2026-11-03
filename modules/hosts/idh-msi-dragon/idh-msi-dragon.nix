{ inputs, den, ... }: {
  # host aspect
  den.aspects.idh-msi-dragon = {
    includes = [
      den.aspects.common # nix settings, openssh, init user passwords
      den.aspects.terminal-tools-base
      den.aspects.laptop
      # LIRMM
      den.aspects.lirmm.common
      den.aspects.lirmm.teams.idh
    ];

    # host NixOS configuration
    nixos =
      { host, pkgs, ... }:
      {
        imports = [
          inputs.disko.nixosModules.default
          ./_disk-config.nix
          ./_hardware-configuration.nix
        ];

        # Bootloader
        boot.loader = {
          systemd-boot.enable = true;
          efi.canTouchEfiVariables = true;
        };
        boot = {
          kernelPackages = pkgs.linuxPackages; # which linux kernel to boot
          supportedFilesystems = [ "ntfs" ]; # ensure the linux kernel has ntfs support
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
