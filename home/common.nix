{
  pkgs,
  inputs,
  config,
  ...
}:
{
  # You can import other home-manager modules here
  imports = [
    # If you want to use modules your own flake exports (from modules/home-manager):
    # outputs.homeManagerModules.example

    # Or modules exported from other flakes (such as nix-colors):
    # inputs.nix-colors.homeManagerModules.default

    # You can also split up your configuration and import pieces of it here:
    ./alacritty.nix
    ./nvim
    ./tmux
    ./themes.nix
  ];

  nixpkgs = {
    # Configure your nixpkgs instance
    config = {
      # Disable if you don't want unfree packages
      allowUnfree = true;
    };
  };

  home = {
    username = "simon";
    homeDirectory = "/home/simon";
    packages = with pkgs; [
      nerdfonts
      gcc
      jq
      yq-go
      rustup
      oh-my-zsh
      go
      fd
      spotify
    ];
  };

  # Enable home-manager and git
  programs.home-manager.enable = true;
  programs.git = {
    enable = true;
    userName = "pyrsson";
    userEmail = "55557230+pyrsson@users.noreply.github.com";
  };

  programs.bash.enable = true;
  programs.zsh = {
    enable = true;
    sessionVariables = {
      FZF_DEFAULT_OPTS = "--reverse --tmux 80%,50% --color dark,prompt:blue,hl+:cyan,hl:cyan,bg+:gray,gutter:-1,fg+:blue:bold,pointer:cyan,info:blue,border:gray";
      FZF_CTRL_R_OPTS = "--reverse --preview 'echo {}' --preview-window down:3:wrap:hidden:border-horizontal --bind '?:toggle-preview'";
      FZF_CTRL_T_OPTS = "--preview 'test -d {} && eza -la --color=always {} || bat --style=numbers --color=always --line-range=:500 {} 2> /dev/null | head -200'";
    };
    shellAliases = {
      ls = "eza --color=always";
    };
    syntaxHighlighting = {
      enable = true;
      highlighters = [ "brackets" ];
      styles = {
        comment = "fg=white,faint";
        single-quoted-argument = "fg=green";
        single-quoted-argument-unclosed = "fg=green";
        double-quoted-argument = "fg=green";
        double-quoted-argument-unclosed = "fg=green";
        command = "fg=cyan";
        builtin = "fg=cyan";
        alias = "fg=cyan";
        path = "fg=blue";
      };
    };
    initExtraFirst = ''
      DISABLE_MAGIC_FUNCTIONS=true
    '';
    initExtra = ''
      # bash word-style
      autoload -Uz backward-kill-word-match

      bindkey '^W' backward-kill-space-word
      zle -N backward-kill-space-word backward-kill-word-match
      zstyle :zle:backward-kill-space-word word-style space

      bindkey '^[^H' backward-kill-bash-word
      zle -N backward-kill-bash-word backward-kill-word-match
      zstyle :zle:backward-kill-bash-word word-style bash
    '';
    cdpath = [
      "~"
      "~/github"
      "~/work"
    ];
    oh-my-zsh = {
      enable = true;
      plugins = [
        "git"
        "fzf"
        "golang"
      ];
      custom = "${inputs.dotfiles}/ohmyzsh/dot-oh-my-zsh/custom";
      theme = "pyrsson";
    };
  };
  programs.fzf = {
    enable = true;
    package = pkgs.unstable.fzf;
  };
  programs = {
    bat.enable = true;
    eza.enable = true;
  };

  fonts.fontconfig.enable = true;

  # home.file.".zshrc".source = ./dotfiles/.zshrc;
  # home.file.".tmux.conf".source = ./dotfiles/.tmux.conf;
  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";
}
