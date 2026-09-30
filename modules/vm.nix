# enables `nix run .#vm`. it is very useful to have a VM
# you can edit your config and launch the VM to test stuff
# instead of having to reboot each time.
{ inputs, den, ... }:
let
  # Get all hostnames from nixosConfigurations
  hostNames = builtins.attrNames inputs.self.nixosConfigurations;
in
{
  # Optionally, remove or generalize the tty-autologin line if needed
  den.aspects.igloo.includes = [ (den.batteries.tty-autologin "tux") ];

  perSystem = { pkgs, ... }: {
    packages = builtins.listToAttrs (
      map (hostName: {
        name = "vm-${hostName}";
        value = pkgs.writeShellApplication {
          name = "vm-${hostName}";
          text =
            let
              host = inputs.self.nixosConfigurations.${hostName}.config;
            in
            ''
              ${host.system.build.vm}/bin/run-${host.networking.hostName}-vm "$@"
            '';
        };
      }) hostNames
    );
  };
}
