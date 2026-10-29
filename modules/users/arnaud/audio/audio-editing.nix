{ den, ... }:
{
  den.aspects.arnaud.audio-editing = {
    description = "Audio editing tools, pipewire + jack, real-time audio";
    includes = [ den.aspects.audio.pipewire-jack ];

    homeManager =
      { pkgs, ... }:
      {
        home.packages = with pkgs; [
          ardour
          qjackctl
          qpwgraph # graphical patchbay
          pavucontrol
        ];
      };
  };
}
