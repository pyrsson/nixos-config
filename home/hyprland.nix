{ config, ... }:
{
  programs.kitty.enable = true; # required for the default Hyprland config
  wayland.windowManager.hyprland.enable = true; # enable Hyprland
  programs.waybar.enable = true;
  programs.waybar.systemd.enable = true;
  services.hyprpaper.enable = true;
  systemd.user.sessionVariables.SSH_AUTH_SOCK = "$XDG_RUNTIME_DIR/keyring/ssh";

  xdg.configFile."hypr".source =
    config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/github/dotfiles/hypr/dot-config/hypr";
  xdg.configFile."waybar".source =
    config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/github/dotfiles/waybar/dot-config/waybar";
  xdg.configFile."swaync".source =
    config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/github/dotfiles/swaync/dot-config/swaync";
  xdg.configFile."wlogout".source =
    config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/github/dotfiles/wlogout/dot-config/wlogout";

  wayland.windowManager.hyprland.systemd.enable = false;
  # Optional, hint Electron apps to use Wayland:
  home.sessionVariables.NIXOS_OZONE_WL = "1";
}
