{
  pkgs,
  inputs,
  config,
  ...
}:
{
  programs.alacritty = {
    enable = true;
    package = pkgs.unstable.alacritty;
  };

  # until toml settings are fixed:
  xdg.configFile."alacritty/alacritty.toml".source =
    config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/github/dotfiles/alacritty/.alacritty.toml";
}
