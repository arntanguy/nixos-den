# defines all hosts + users + homes.
# then config their aspects in as many files you want
{ den, ... }:
{
  flake-file.inputs = {
    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  # --- Pipeline wiring ---
  # Enter flake-parts scope from flake-system.
  den.schema.flake-system.includes = [ den.policies.system-to-flake-parts ];
  # Exclude vanilla packages route — handled via flake-parts scope.
  den.schema.flake-system.excludes = [ den.policies.packages-to-flake ];

  # ardell host
  den.hosts.x86_64-linux.ardell = {
    description = "Dell Precision 7569 / LIRMM / IDH";
    users.arnaud = { };
    users.guest = { };

    # XXX: freeform, better format
    ipSuffix = "42";
    # ethernetInterface = "enp7s0";
    ethernetInterface = "eth0";
  };

  # panda control host
  den.hosts.x86_64-linux.bamboo = {
    description = "Bamboo / Panda Control / LIRMM / IDH";
    users.arnaud = { };
    users.panda = { };
    users.guest = { };

    # XXX: freeform, better format
    ipSuffix = "43";
    # ethernetInterface = "enp7s0";
    ethernetInterface = "eth0";
  };

  # huiting13 host
  den.hosts.x86_64-linux.huiting13 = {
    description = "Dell XPS-13-9370 / LIRMM / IDH";
    users.arnaud = { };
    users.guest = { };

    # XXX: freeform, better format
    ipSuffix = "44";
    ethernetInterface = "enp0s20f0u1u1";
    # XXX: must be set to false for nixos-anywhere
    # then copy the user's age keys to ~/.config/sops/age/keys.txt
    # then put to true
    # then run nixos-rebuild switch
    # enableSecrets = true;
    enableSecrets = true;
  };

  # define an standalone home-manager for tux
  # den.homes.x86_64-linux.tux = { };

  # be sure to add nix-darwin input for this:
  # den.hosts.aarch64-darwin.apple.users.alice = { };

  # other hosts can also have user tux.
  # den.hosts.x86_64-linux.south = {
  #   wsl = { }; # add nixos-wsl input for this.
  #   users.tux = { };
  #   users.orca = { };
  # };
}
