{ pkgs, ... }:
{
  programs.hyprland.enable = true;
  programs.hyprland.withUWSM = true;
  services.hypridle.enable = true;
  programs.hyprlock.enable = true;
  programs.uwsm.enable = true;
  services.gnome.gnome-keyring.enable = true;
  security.pam.services.gdm.enableGnomeKeyring = true;

  environment.systemPackages = with pkgs; [
    waybar
    # dunst
    fuzzel
    grimblast
    hyprpaper
    hyprpicker
    wlogout
    wlr-randr
    swaynotificationcenter
    playerctl
    cliphist
    font-awesome
    networkmanagerapplet
    overskride
    ydotool
  ];
  environment.sessionVariables.NIXOS_OZONE_WL = "1";
}
