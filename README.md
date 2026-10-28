# Getting Started Guide

Steps you can follow after cloning this template:

- Be sure to read the [den documentation](https://den.denful.dev)

- Update den input.

```console
nix flake update den
```

- Edit [modules/hosts.nix](modules/hosts.nix)

- Build

```console
# default action is build
nix run .#igloo

# pass any other nh action
nix run .#igloo -- switch
```

- Run the VM

We recommend to use a VM develop cycle so you can play with the system before applying to your hardware.

See [modules/vm.nix](modules/vm.nix)

```console
nix run .#vm
```

# How-to

## Install using nixos-anywhere

- Add `./modules/hosts/<hostname>/_disko-config.nix`
- Import `_disko-config.nix` in your `modules/hosts/<hostname>/<hostname>.nix` (see `huiting13.nix` for example) 
- Setup the luks password:
  ```sh
  MY_PASS=$(mktemp)
  echo -n "your-super-secret-password" > "$MY_PASS"
  ```
- On the destination host where you want to install, boot any system supporting kexec (nixos installer, any linux distro, etc) 
- Install with (replace hostname / ip)
  ```sh
  nix run github:nix-community/nixos-anywhere -- --flake .#huiting13 --target-host root@192.168.12.247 --generate-hardware-config nixos-generate-config ./modules/hosts/huiting13/_hardware-configuration.nix --disk-encryption-keys /tmp/disk-encryption.key "$MY_PASS
  ```
- You're done, your destination machine is formatted and installed, magic!
- Commit the generated `_hardware-configuration.nix` file to your repo, so you can rebuild the system later.

## Update remotely

- Update the destination machine with:

```
nixos-rebuild switch --flake .#huiting13 --target-host root@<IP-ADDRESS-OR-HOSTNAME> --use-remote-sudo
```

## Add a new flake input

This repository uses [flake-file](https://flake-file.denful.dev/) to auto-generate the flake.nix file from nix modules in ./modules. To add a new flake: 

- Add a `flake-file.inputs` to your module:

```
  flake-file.inputs = {
    treefmt-nix.url = "github:numtide/treefmt-nix";
    treefmt-nix.inputs.nixpkgs.follows = "nixpkgs";
  };
```

- Run `nix run .#write-flake`
- Write your module code using the new flake input
