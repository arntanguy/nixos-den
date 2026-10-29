{ inputs, den, ... }: {
  # host aspect
  den.aspects.huiting13 = {
    includes = [
      den.aspects.common # nix settings, openssh, init user passwords
      den.aspects.terminal-tools-base
      den.aspects.laptop
      # LIRMM
      den.aspects.lirmm.teams.idh
    ];

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
