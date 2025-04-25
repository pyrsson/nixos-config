{ pkgs, ... }:
{
  programs.gamescope = {
    enable = true;
    package = pkgs.unstable.gamescope;
  };
  programs.steam = {
    enable = true;
    package = pkgs.unstable.steam;
    protontricks = {
      enable = true;
      package = pkgs.unstable.protontricks;
    };
    gamescopeSession = {
      enable = true;
      env = {
        WLR_RENDERER = "vulkan";
        DXVK_HDR = "1";
        ENABLE_GAMESCOPE_WSI = "1";
        WINE_FULLSCREEN_FSR = "1";
        # Games allegedly prefer X11
        SDL_VIDEODRIVER = "x11";
      };
      args = [
        "--xwayland-count 2"
        "--expose-wayland"

        "-e" # Enable steam integration
        "--steam"

        "--adaptive-sync"
        "--hdr-enabled"
        "--hdr-itm-enable"

        # External monitor
        "--prefer-output DP-1"
        "--output-width 3440"
        "--output-height 1440"
        # "-r 75"

        # Laptop display
        # "--prefer-output eDP-1"
        # "--output-width 2560"
        # "--output-height 1600"
        # "-r 120"

        # "--prefer-vk-device" # lspci -nn | grep VGA
        # "1002:73ef" # Dedicated
        # 1002:1681 # Integrated
      ];
    };
  };
}
