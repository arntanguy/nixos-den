{ den, ... }:
{
  den.aspects.audio.pipewire-jack = {
    description = "Enable PipeWire with JACK support and real-time permissions for audio group";
    nixos =
      {
        user,
        pkgs,
        ...
      }:
      {
        environment.systemPackages = with pkgs; [
          pavucontrol
          qpwgraph # graphical patchbay
        ];

        # Enable PipeWire with JACK support
        services.pipewire = {
          enable = true;
          audio.enable = true;
          jack.enable = true;
        };

        # Real-time permissions for audio group
        security.pam.loginLimits = [
          {
            domain = "@audio";
            type = "soft";
            item = "memlock";
            value = "unlimited";
          }
          {
            domain = "@audio";
            type = "hard";
            item = "memlock";
            value = "unlimited";
          }
          {
            domain = "@audio";
            type = "soft";
            item = "rtprio";
            value = "95";
          }
          {
            domain = "@audio";
            type = "hard";
            item = "rtprio";
            value = "99";
          }
        ];

        # Add user to the audio group
        users.users.${user.name}.extraGroups = [ "audio" ];
      };
  };
}
