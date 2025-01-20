{ pkgs, ... }:
{
  home.packages = [
    (pkgs.unstable.lutris.override {
      extraPkgs = p: [
        p.wineWowPackages.stable
        p.wineWowPackages.stagingFull
        p.winetricks
        p.pixman
        p.libjpeg
        p.zenity
      ];
    })
  ];
}
