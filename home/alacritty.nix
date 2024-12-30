{ pkgs, inputs, ... }:
{
  programs.alacritty = {
    enable = true;
    package = pkgs.unstable.alacritty;
  };

  # until toml settings are fixed:
  xdg.configFile."alacritty/alacritty.toml" = {
    source = "${inputs.dotfiles}/alacritty/.alacritty.toml";
  };
}
