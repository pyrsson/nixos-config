{ pkgs, ... }: {
  home.packages = with pkgs; [
    fd
    lua-language-server
    rust-analyzer-unwrapped
    nil
  ];

  programs.neovim = {
    enable = true;
    package = pkgs.neovim-nightly;
    vimAlias = true;
    coc.enable = false;
    withNodeJs = true;
  };

  home.file."./.config/nvim/" = {
    source = ./nvim;
    recursive = true;
  };
}
