{pkgs, ...}:
let
  tmuxattach = pkgs.writeShellScriptBin "ta" (builtins.readFile ./dotfiles/functions/ta);
in 
{
  programs.tmux = {
    enable = true;
    plugins = with pkgs; [
      tmuxPlugins.prefix-highlight
      tmuxPlugins.tmux-thumbs
    ];
    extraConfig = 
      ''
      ${ builtins.readFile ./dotfiles/tmux.conf }
      run-shell ${pkgs.tmuxPlugins.prefix-highlight}/share/tmux-plugins/prefix-highlight/prefix_highlight.tmux
      '';
  };
  home.packages = [
    tmuxattach
  ];
}
