{
  services.xserver = {
    enable = true;
    layout = "se";
    xkbVariant = "nodeadkeys";
    displayManager.gdm.enable = true;
    desktopManager.gnome.enable = true;
  };
}
