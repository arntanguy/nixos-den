{
  # see https://nixos.wiki/wiki/Fwupd
  den.aspects.firmware-update = {
    description = "fwupd is a simple daemon allowing you to update some devices' firmware, including UEFI for several machines.";
    nixos = {
      services.fwupd.enable = true;
    };
  };
}
