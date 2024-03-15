{pkgs, ...}:
let
  treesitterWithGrammars = pkgs.vimPlugins.nvim-treesitter.withAllGrammars;
in
{
  programs.neovim = {
    enable = true;
    # package = pkgs.unstable.neovim;
    vimAlias = true;
    vimdiffAlias = true;
    viAlias = true;
    defaultEditor = true;
    coc.enable = false;
    withNodeJs = true;
    extraPackages = with pkgs; [
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
      nil
      xclip
      wl-clipboard
      deno
      nodePackages.bash-language-server
      nodePackages.vscode-json-languageserver-bin
      shfmt
      shellcheck
    ];
    plugins = [
      treesitterWithGrammars
    ];
  };

  home.sessionVariables.EDITOR = "nvim";

  xdg.configFile."nvim/" = {
    source = ./lazyvim;
    recursive = true;
  };

  home.file."./.local/share/nvim/nix/nvim-treesitter/" = {
    recursive = true;
    source = treesitterWithGrammars;
  };
}
