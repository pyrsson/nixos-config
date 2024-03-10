{pkgs, ...}:
let
  tmuxattach = pkgs.writeShellScriptBin "ta" (builtins.readFile ./ta);
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
      ${ builtins.readFile ./tmux.conf }
      run-shell ${pkgs.tmuxPlugins.prefix-highlight}/share/tmux-plugins/prefix-highlight/prefix_highlight.tmux
      '';
  };
  home.packages = [
    tmuxattach
  ];
}