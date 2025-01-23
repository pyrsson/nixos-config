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
    extraConfig = {
      init.defaultBranch = "main";
      pull.rebase = true;
    };
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
      cat = "bat";
    };
    zplug = {
      enable = true;
      plugins = [
        { name = "davidde/git"; }
      ];
    };
    history = {
      append = true;
      ignoreDups = true;
      expireDuplicatesFirst = true;
      save = 10000;
      size = 10000;
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
    defaultKeymap = "emacs";
    autocd = true;
    initExtra = ''
      bindkey "''${terminfo[kpp]}" up-line-or-history
      bindkey "''${terminfo[knp]}" down-line-or-history

      autoload -U up-line-or-beginning-search
      zle -N up-line-or-beginning-search
      bindkey "^[[A" up-line-or-beginning-search

      autoload -U down-line-or-beginning-search
      zle -N down-line-or-beginning-search
      bindkey "^[[B" down-line-or-beginning-search

      bindkey '^?' backward-delete-char
      bindkey "^[[3~" delete-char
      bindkey "^[3;5~" delete-char

      bindkey '^[[3;5~' kill-word
      bindkey '^[[1;5C' forward-word
      bindkey '^[[1;5D' backward-word

      bindkey ' ' magic-space
      # Edit the current command line in $EDITOR
      autoload -U edit-command-line
      zle -N edit-command-line
      bindkey '\C-x\C-e' edit-command-line

      # bash word-style
      autoload -Uz backward-kill-word-match

      bindkey '^W' backward-kill-space-word
      zle -N backward-kill-space-word backward-kill-word-match
      zstyle :zle:backward-kill-space-word word-style space

      bindkey '^[^H' backward-kill-bash-word
      zle -N backward-kill-bash-word backward-kill-word-match
      zstyle :zle:backward-kill-bash-word word-style bash

      zstyle ':completion:*' matcher-list 'm:{A-Za-z}={A-Za-z}'

      autoload -U colors
      colors

      setopt PROMPT_SUBST
      PROMPT='%F{blue}%~%f %(?.%F{cyan}.%F{red})%(!.#.>)%f '
      RPS1="%(?..%{$fg[red]%}%? ↵%{$reset_color%})"

      source <(fzf --zsh)
    '';
    cdpath = [
      "~"
      "~/github"
      "~/work"
    ];
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
