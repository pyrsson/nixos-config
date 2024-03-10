{outputs, pkgs, ...}:
{
  # need 0.13 for toml config
  nixpkgs = {
    overlays = [
      outputs.overlays.unstable-packages
    ];
  };

  programs.alacritty = {
    enable = true;
    package = pkgs.unstable.alacritty;
  #   settings = {
  #     import = [
  #       "~/.local/share/nvim/lazy/tokyonight.nvim/extras/alacritty/tokyonight_moon.toml"
  #     ];
  #     env = {
  #       TERM = "xterm-256color";
  #     };
  #     window = {
  #       decorations = "none";
  #       startup_mode = "Maximized";
  #       dynamic_title = false;
  #     };
  #     font = {
  #       normal = {
  #         family = "Hack Nerd Font";
  #       };
  #       size = 12;
  #     };
  #     live_config_reload = true;
  #   };
  };

  # until toml settings are fixed:
  home.file.".config/alacritty/alacritty.toml" = {
    text = ''
      import = [
        "~/.local/share/nvim/lazy/tokyonight.nvim/extras/alacritty/tokyonight_moon.toml"
      ]
      live_config_reload = true
      [env]
      TERM = "xterm-256color"
      [window]
      decorations = "None"
      # broken
      # startup_mode = "Maximized"
      dynamic_title = false
      [font]
      normal = { family = "Hack Nerd Font" }
      size = 12
    '';
  };
}