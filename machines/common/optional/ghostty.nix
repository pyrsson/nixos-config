{ pkgs, ... }:
{
  environment.systemPackages = [
    pkgs.unstable.ghostty
  ];
}
