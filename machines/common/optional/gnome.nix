{ pkgs, ... }:
{
  services.xserver = {
    enable = true;
    layout = "se";
    xkbVariant = "nodeadkeys";
    displayManager.gdm.enable = true;
    desktopManager.gnome.enable = true;
  };
  environment.systemPackages = with pkgs; [
    gnome3.gnome-tweaks
    gnome3.gnome-shell-extensions
    gnomeExtensions.tray-icons-reloaded
  ];
}
