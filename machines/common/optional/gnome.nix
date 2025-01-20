{ pkgs, lib, ... }:
let
  tokyonight-gtk-theme = pkgs.unstable.tokyonight-gtk-theme.override {
    tweakVariants = [ "moon" ];
  };
in
{
  services = {
    xserver = {
      enable = true;
      dpi = 96;
      displayManager.gdm.enable = true;
      desktopManager.gnome.enable = true;
      upscaleDefaultCursor = true;
      xkb = {
        variant = "nodeadkeys";
        layout = "se";
      };
    };
    gnome.games.enable = true;
  };
  environment.systemPackages =
    with pkgs;
    [
      gnome-tweaks
      gnome-themes-extra
      gnome-shell-extensions
      gdm-settings
      xsettingsd
      xorg.xrdb
      gtk-engine-murrine
      bibata-cursors
      tokyonight-gtk-theme
    ]
    ++ (with gnomeExtensions; [
      appindicator
      blur-my-shell
      clipboard-indicator
      user-themes
    ]);
  programs.kdeconnect = {
    enable = true;
    package = pkgs.gnomeExtensions.gsconnect;
  };

  programs.dconf = {
    enable = true;
    profiles = {
      gdm.databases = [
        {
          settings = {
            "org/gnome/desktop/peripherals/mouse" = {
              speed = -0.34;
            };
          };
        }
      ];
      user.databases = [
        {
          settings = {
            "org/gnome/shell/extensions/user-theme" = {
              name = "Tokyonight-Dark-Moon";
            };
            "org/gnome/desktop/calendar".show-weekdate = true;
            "org/gnome/desktop/interface".color-scheme = "prefer-dark";
            "org/gnome/shell".disable-user-extensions = false;
            "org/gnome/shell".enabled-extensions = [
              "appindicatorsupport@rgcjonas.gmail.com"
              "clipboard-indicator@tudmotu.com"
              "user-theme@gnome-shell-extensions.gcampax.github.com"
            ];
          };
        }
      ];
    };
  };
}
