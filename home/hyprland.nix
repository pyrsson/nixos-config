{
  pkgs,
  config,
  lib,
  ...
}:
{
  wayland.windowManager.hyprland = {
    enable = true; # enable Hyprland
    systemd.enable = false;
  };
  programs.waybar.enable = true;
  services.hyprpaper.enable = true;
  services.hypridle.enable = true;
  services.gnome-keyring.enable = true;
  services.gnome-keyring.components = [ "ssh" ];
  systemd.user.sessionVariables.SSH_AUTH_SOCK = "$XDG_RUNTIME_DIR/keyring/ssh";

  xdg.configFile."hypr".source =
    config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/github/dotfiles/hypr/dot-config/hypr";
  xdg.configFile."waybar".source =
    config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/github/dotfiles/waybar/dot-config/waybar";
  xdg.configFile."swaync".source =
    config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/github/dotfiles/swaync/dot-config/swaync";
  xdg.configFile."wlogout".source =
    config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/github/dotfiles/wlogout/dot-config/wlogout";
  xdg.configFile."anyrun".source =
    config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/github/dotfiles/anyrun/dot-config/anyrun";

  systemd.user = {
    enable = true;
    startServices = "sd-switch";
    services = {
      # For clipboard
      cliphist = lib.mkForce {
        Unit = {
          Description = "Clipboard history \"manager\" for wayland";
          Documentation = [ "https://github.com/sentriz/cliphist" ];
          After = [ "graphical-session.target" ];
        };

        Service = {
          Type = "exec";
          ExecCondition = "${pkgs.systemd}/lib/systemd/systemd-xdg-autostart-condition \"Hyprland\" \"\"";
          ExecStart = "${pkgs.wl-clipboard}/bin/wl-paste --watch ${pkgs.cliphist}/bin/cliphist -max-items 10 store";
          Restart = "on-failure";
          Slice = "app-graphical.slice";
        };

        Install = {
          WantedBy = [ "graphical-session.target" ];
        };
      };

      # For Hyprpaper
      hyprpaper = lib.mkForce {
        Unit = {
          Description = "Hyprpaper wallpaper utility for Hyprland";
          Documentation = [ "man:hyprpaper(1)" ];
          After = [ "graphical-session.target" ];
        };

        Service = {
          Type = "exec";
          ExecCondition = "${pkgs.systemd}/lib/systemd/systemd-xdg-autostart-condition \"Hyprland\" \"\"";
          ExecStart = "${pkgs.hyprpaper}/bin/hyprpaper";
          Restart = "on-failure";
          Slice = "background-graphical.slice";
        };

        Install = {
          WantedBy = [ "graphical-session.target" ];
        };
      };

      # Waybar started by UWSM
      waybar = lib.mkForce {
        Unit = {
          Description = "Highly customizable Wayland bar for Sway and Wlroots based compositors";
          Documentation = [ "man:waybar(5)" ];
          After = [ "graphical-session.target" ];
        };

        Service = {
          Type = "exec";
          ExecCondition = "${pkgs.systemd}/lib/systemd/systemd-xdg-autostart-condition \"Hyprland\" \"\"";
          ExecStart = "${pkgs.waybar}/bin/waybar";
          ExecReload = "${pkgs.util-linux}/bin/kill -SIGUSR2 $MAINPID";
          Restart = "on-failure";
          Slice = "app-graphical.slice";
        };

        Install = {
          WantedBy = [ "graphical-session.target" ];
        };
      };

      # for Hypridle
      hypridle.Unit.After = lib.mkForce [ "graphical-session.target" ];
    };
  };
  # Optional, hint Electron apps to use Wayland:
  home.sessionVariables.NIXOS_OZONE_WL = "1";
}
