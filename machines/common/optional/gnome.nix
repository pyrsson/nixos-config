{ pkgs, ... }:
{
  services = {
    xserver = {
      enable = true;
      displayManager.gdm.enable = true;
      desktopManager.gnome.enable = true;
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
      gnome3.gnome-tweaks
      gnome3.gnome-shell-extensions
    ]
    ++ (with gnomeExtensions; [
      appindicator
      blur-my-shell
      clipboard-indicator
    ]);
  programs.kdeconnect = {
    enable = true;
    package = pkgs.gnomeExtensions.gsconnect;
  };

  programs.dconf.profiles = {
    user.databases = [
      {
        settings = {
          "org/gnome/desktop/calendar".show-weekdate = true;
          "org/gnome/desktop/interface".color-scheme = "prefer-dark";
          "org/gnome/shell".enabled-extensions = [
            "blur-my-shell@aunetx"
            "appindicatorsupport@rgcjonas.gmail.com"
            "clipboard-indicator@tudmotu.com"
          ];
        };
      }
    ];
  };
}
