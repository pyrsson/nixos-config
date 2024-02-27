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

  # Treesitter is configured as a locally developed module in lazy.nvim
  # we hardcode a symlink here so that we can refer to it in our lazy config
  home.file."./.local/share/nvim/nix/nvim-treesitter/" = {
    recursive = true;
    source = treesitterWithGrammars;
  };

}
