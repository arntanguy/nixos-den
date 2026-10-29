{ den, ... }:
{
  den.aspects.arnaud.publication = {
    description = "Publication/Book management with Zotero/Calibre";
    includes = [
      den.aspects.arnaud.syncthing
      (den.batteries.unfree [ "firefox-esr-140-bin-unwrapped" ]) # for zotero
      (den.batteries.insecure [ "firefox-esr-140-bin-unwrapped-140.17.0esr" ])
    ];
    homeManager =
      {
        pkgs,
        ...
      }:
      {
        home.packages = [ pkgs.zotero ];

        programs.calibre = {
          enable = true;
          plugins = [ ];
        };
      };
  };
}
