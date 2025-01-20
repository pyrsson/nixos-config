{ pkgs, ... }:
let
  tokyonight-gtk-theme = pkgs.unstable.tokyonight-gtk-theme.override {
    tweakVariants = [ "moon" ];
  };
in
{
  home.pointerCursor = {
    gtk.enable = true;
    package = pkgs.bibata-cursors;
    name = "Bibata-Modern-Ice";
    size = 24;
  };
  gtk = {
    enable = true;
    theme = {
      name = "Tokyonight-Dark-Moon";
      package = tokyonight-gtk-theme;
    };
    cursorTheme = {
      name = "Bibata-Modern-Ice";
    };
  };
  dconf.settings = {
    "org/gnome/shell/extensions/user-theme" = {
      name = "Tokyonight-Dark-Moon";
    };
  };
}
