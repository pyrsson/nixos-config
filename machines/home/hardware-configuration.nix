# Do not modify this file!  It was generated by ‘nixos-generate-config’
# and may be overwritten by future invocations.  Please make changes
# to /etc/nixos/configuration.nix instead.
{
  config,
  lib,
  modulesPath,
  pkgs,
  ...
}:

{
  imports = [ (modulesPath + "/installer/scan/not-detected.nix") ];

  boot.initrd.availableKernelModules = [ "nvme" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-amd" ];
  boot.extraModulePackages = [ ];
  boot.kernelPackages = pkgs.linuxPackages_latest;

  fileSystems."/" = {
    device = "/dev/disk/by-uuid/ae67cd9f-bce3-448d-bb27-e9f75e32a2f0";
    fsType = "btrfs";
    options = [ "subvol=@nixos" ];
  };

  fileSystems."/home" = {
    device = "/dev/disk/by-uuid/ae67cd9f-bce3-448d-bb27-e9f75e32a2f0";
    fsType = "btrfs";
    options = [ "subvol=@nixos-home" ];
  };

  fileSystems."/games" = {
    device = "/dev/disk/by-uuid/ae67cd9f-bce3-448d-bb27-e9f75e32a2f0";
    fsType = "btrfs";
    options = [ "subvol=@games" ];
  };

  # fileSystems."/boot" =
  #   { device = "/dev/disk/by-uuid/8af1b0c2-6761-4738-95ee-28625068fb29";
  #     fsType = "ext4";
  #   };

  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/B9A0-07EC";
    fsType = "vfat";
  };

  swapDevices = [ { device = "/dev/disk/by-uuid/f2a6a9e1-9e09-4bf8-b0cf-4fb778c1111b"; } ];

  # Enables DHCP on each ethernet and wireless interface. In case of scripted networking
  # (the default) this is the recommended approach. When using systemd-networkd it's
  # still possible to use this option, but it's recommended to use it in conjunction
  # with explicit per-interface declarations with `networking.interfaces.<interface>.useDHCP`.
  networking.useDHCP = lib.mkDefault true;
  # networking.interfaces.enp10s0f3u4u2.useDHCP = lib.mkDefault true;
  # networking.interfaces.enp7s0.useDHCP = lib.mkDefault true;
  # networking.interfaces.wlp6s0.useDHCP = lib.mkDefault true;

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
