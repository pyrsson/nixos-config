{ pkgs, ... }:
{
  home.packages = [
    (pkgs.unstable.lutris.override {
      extraPkgs = p: [
        p.wineWowPackages.staging
        p.pixman
        p.libjpeg
        p.zenity
      ];
    })
  ];
}
