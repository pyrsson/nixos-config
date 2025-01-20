{ pkgs, config, ... }:
let
  treesitterWithGrammars = pkgs.vimPlugins.nvim-treesitter.withAllGrammars;
in
{
  programs.neovim = {
    enable = true;
    package = pkgs.unstable.neovim-unwrapped;
    vimAlias = true;
    vimdiffAlias = true;
    viAlias = true;
    defaultEditor = true;
    coc.enable = false;
    withNodeJs = true;
    extraPackages = with pkgs.unstable; [
      lua-language-server
      rust-analyzer-unwrapped
      taplo
      typescript
      gopls
      gofumpt
      delve
      dockerfile-language-server-nodejs
      docker-compose-language-service
      yaml-language-server
      hadolint
      xclip
      wl-clipboard
      deno
      nodePackages.bash-language-server
      nodePackages.vscode-langservers-extracted
      shfmt
      shellcheck
      nixfmt-rfc-style
      nixd
      nil
      chafa
    ];
    plugins = [ treesitterWithGrammars ];
  };

  home.sessionVariables.EDITOR = "nvim";

  xdg.configFile."nvim/" = {
    source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/github/dotfiles/lazyvim/dot-config/nvim";
  };

  home.file."./.local/share/nvim/nix/nvim-treesitter/" = {
    recursive = true;
    source = treesitterWithGrammars;
  };
}
