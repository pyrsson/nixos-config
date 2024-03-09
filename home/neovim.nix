{pkgs, ...}:
{
  programs.neovim = {
    enable = true;
    vimAlias = true;
    vimdiffAlias = true;
    viAlias = true;
    defaultEditor = true;
    coc.enable = false;
    withNodeJs = true;
    extraPackages = with pkgs; [
      lua-language-server
      nil
      xclip
      wl-clipboard
    ];
  };

  home.file."./.config/nvim/" = {
    source = ./dotfiles/lazyvim;
    recursive = true;
  };
}
