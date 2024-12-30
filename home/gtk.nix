{ pkgs, inputs, ... }:
let
  tokyonight-gtk-theme = pkgs.unstable.tokyonight-gtk-theme.override {
    tweakVariants = [ "moon" ];
  };
in
{
  gtk = {
    enable = true;
    theme = {
      name = "Tokyonight-Dark-Moon";
      package = tokyonight-gtk-theme;
    };
    cursorTheme = {
      name = "catppuccin-frappe-dark-cursors";
      package = pkgs.catppuccin-cursors.frappeDark;
    };
  };
  dconf.settings = {
    "org/gnome/shell/extensions/user-theme" = {
      name = "Tokyonight-Dark-Moon";
    };
  };
}
