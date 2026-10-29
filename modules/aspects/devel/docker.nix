# Development Tools Split
{ den, inputs, ... }:
{
  # System-wide development infrastructure
  den.aspects.devel.docker = {
    nixos =
      { pkgs, ... }:
      {
        virtualisation.docker.enable = true;
        environment.systemPackages = with pkgs; [
          # System & Container Infrastructure
          docker
          docker-compose
          lazydocker
          devpod
        ];
      };
  };
}
