{ pkgs, inputs, ... }:
{
  programs.hyprland = {
    enable = true;
    package = pkgs.hyprland.override { withSystemd = true; };
    withUWSM = true;
  };
  services.hypridle.enable = true;
  programs.hyprlock.enable = true;
  security.pam.services.gdm.enableGnomeKeyring = true;
  security.pam.services.hyperlock = { };

  environment.systemPackages =
    with pkgs.unstable;
    [
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
    ]
    ++ [ inputs.anyrun.packages.${pkgs.system}.anyrun-with-all-plugins ];
  environment.sessionVariables.NIXOS_OZONE_WL = "1";
}
