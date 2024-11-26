{ pkgs, inputs, ... }:
{
  programs.alacritty = {
    enable = true;
  };

  # until toml settings are fixed:
  xdg.configFile."alacritty/alacritty.toml" = {
    source = "${inputs.dotfiles}/alacritty/.alacritty.toml";
  };
}
