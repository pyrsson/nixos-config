{ pkgs, ... }: {
  # You can import other home-manager modules here
  imports = [
    # If you want to use modules your own flake exports (from modules/home-manager):
    # outputs.homeManagerModules.example

    # Or modules exported from other flakes (such as nix-colors):
    # inputs.nix-colors.homeManagerModules.default

    # You can also split up your configuration and import pieces of it here:
    ./common.nix
    ./alacritty.nix
  ];

  home.packages = with pkgs; [
    (discord.override {
      withOpenASAR = true;
    })
  ];

  xdg.desktopEntries.discord = {
    name = "Discord";
    exec = "discord --disable-gpu";
    icon = "${pkgs.discord}/opt/Discord/discord.png";
  };

  home.stateVersion = "23.11";
}
