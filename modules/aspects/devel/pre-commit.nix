# Nix developpement tools
{
  den.aspects.devel.pre-commit = {
    description = "Enables pre-commit/prek code formatting (activates nix-ld to support non nixos-native binaries)";

    nixos = { pkgs, ... }: {
      programs = {
        # Automatically creates a loader in /lib/* to avoid patching stuff
        # Makes prek and pre-commit work, in particular with clang-format binaries
        # See: https://wiki.nixos.org/wiki/Nix-ld
        nix-ld.enable = true;
      };
      environment.systemPackages = with pkgs; [
        pre-commit
        prek
      ];
    };
  };
}
