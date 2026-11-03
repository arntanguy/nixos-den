{ den, ... }:
{
  den.aspects.idh-msi-dragon.nvidia = {
    includes = [ ];
    nixos = { config, ... }: {

      # --- ADD THESE LINES TO FORCE DEDICATED NVIDIA MODE ---
      hardware.nvidia = {
        package = config.boot.kernelPackages.nvidiaPackages.stable;
        prime = {
          # Enable PRIME sync mode so the display output is driven directly by NVIDIA
          sync.enable = true;

          # Tell NixOS what your Bus IDs are (from your lspci output earlier)
          # Intel iGPU is 00:02:0
          intelBusId = "PCI:0:2:0";
          # NVIDIA dGPU is 01:00:0
          nvidiaBusId = "PCI:1:0:0";
        };
      };
    };
  };
}
