{ den, ... }:
{
  den.aspects.arnaud.networking.wifi = {
    includes = [
      den.aspects.arnaud.sops
    ]
    ++ (with den.aspects.arnaud.networking.wifi; [
      android-ap
      eduroam
      home-brest
      lirmm
    ]);
  };
}
