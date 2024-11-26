{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}:
{
  # You can import other NixOS modules here
  imports = [
    ./hardware-configuration.nix

    ../common
    ../common/optional/sshd.nix
    ../common/optional/gnome.nix
  ];

  networking.hostName = "nix-vm";

  boot.loader.grub = {
    enable = true;
    device = "/dev/vda";
    useOSProber = true;
  };
  system.stateVersion = "23.11";
}
