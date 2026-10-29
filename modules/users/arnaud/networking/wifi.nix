{ den, ... }:
{
  den.aspects.arnaud.networking.wifi = {
    includes = with den.aspects.arnaud.networking.wifi; [
      android-ap
      eduroam
      home-brest
      lirmm
    ];
  };
}
