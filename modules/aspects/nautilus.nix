# Configures nautilus file manager with gvfs support
# for mounting drives and network shares.
#
# for google-drive support, connect using gnome-online-accounts-gtk
{
  den.aspects.nautilus = {
    description = "Nautilus file manager with gvfs support for mounting drives and network shares.";
    nixos =
      {
        pkgs,
        ...
      }:
      {
        environment.systemPackages = with pkgs; [
          nautilus
          gnome-online-accounts
          gnome-online-accounts-gtk
        ];
        services.gnome.gnome-online-accounts.enable = true;
        services.gvfs.enable = true;
      };
  };
}
