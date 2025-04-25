{ pkgs, ... }:
# let
#   steam-with-pkgs = pkgs.unstable.steam.override {
#     extraPkgs =
#       pkgs: with pkgs; [
#         xorg.libXcursor
#         xorg.libXi
#         xorg.libXinerama
#         xorg.libXScrnSaver
#         libpng
#         libpulseaudio
#         libvorbis
#         stdenv.cc.cc.lib
#         libkrb5
#         keyutils
#         gamescope
#         mangohud
#       ];
#   };
# in
{
  # home.packages = with pkgs; [
  #   steam-with-pkgs
  #   protontricks
  #   protonup-qt
  # ];
  # programs.gamescope = {
  #   enable = true;
  #   package = pkgs.unstable.gamescope;
  # };
  # programs.steam = {
  #   gamescopeSession = {
  #     enable = true;
  #     env = {
  #       WLR_RENDERER = "vulkan";
  #       DXVK_HDR = "1";
  #       ENABLE_GAMESCOPE_WSI = "1";
  #       WINE_FULLSCREEN_FSR = "1";
  #       # Games allegedly prefer X11
  #       SDL_VIDEODRIVER = "x11";
  #     };
  #     args = [
  #       "--xwayland-count 2"
  #       "--expose-wayland"
  #
  #       "-e" # Enable steam integration
  #       "--steam"
  #
  #       "--adaptive-sync"
  #       "--hdr-enabled"
  #       "--hdr-itm-enable"
  #
  #       # External monitor
  #       "--prefer-output DP-1"
  #       "--output-width 3440"
  #       "--output-height 1440"
  #       "-r 100"
  #
  #       # Laptop display
  #       # "--prefer-output eDP-1"
  #       # "--output-width 2560"
  #       # "--output-height 1600"
  #       # "-r 120"
  #
  #       # "--prefer-vk-device" # lspci -nn | grep VGA
  #       # "1002:73ef" # Dedicated
  #       # 1002:1681 # Integrated
  #     ];
  #   };
  # };
  #
}
