{ pkgs, ... }:
let
  autostartPrograms = [
    pkgs.steam
    pkgs.vesktop
  ];
in
{
  # You can import other home-manager modules here
  imports = [
    # If you want to use modules your own flake exports (from modules/home-manager):
    # outputs.homeManagerModules.example

    # Or modules exported from other flakes (such as nix-colors):
    # inputs.nix-colors.homeManagerModules.default

    # You can also split up your configuration and import pieces of it here:
    ./common.nix
    ./gtk.nix
    ./alacritty.nix
    ./steam.nix
    ./lutris.nix
    ./themes.nix
  ];

  home.packages = with pkgs; [ vesktop ];

  xdg.configFile = builtins.listToAttrs (
    map (pkg: {
      name = "autostart/" + pkg.name + ".desktop";
      value =
        if pkg ? desktopItem then
          {
            # Application has a desktopItem entry.
            # Assume that it was made with makeDesktopEntry, which exposes a
            # text attribute with the contents of the .desktop file
            text = pkg.desktopItem.text;
          }
        else
          {
            # Application does *not* have a desktopItem entry. Try to find a
            # matching .desktop name in /share/apaplications
            source = (pkg + "/share/applications/" + pkg.name + ".desktop");
          };
    }) autostartPrograms
  );
  home.stateVersion = "23.11";
}
