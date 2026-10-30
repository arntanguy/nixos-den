{ den, ... }:
{
  den.aspects.communication = {
    includes = [
      (den.batteries.unfree [
        "slack"
        "zoom"
      ])
    ];
    nixos =
      { pkgs, ... }:
      {
        environment.systemPackages = with pkgs; [
          element-desktop # matrix
          slack
          zoom-us
        ];
      };
  };
}
