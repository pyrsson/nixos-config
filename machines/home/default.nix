{ config, ... }:
{
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix

    ../common
    ../common/optional/gnome.nix
    ../common/optional/ghostty.nix
    ../common/optional/umu.nix
  ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = false;
  # boot.loader = {
  #   efi = {
  #     canTouchEfiVariables = true;
  #     efiSysMountPoint = "/boot/efi";
  #   };
  #   grub = {
  #     efiSupport = true;
  #     device = "nodev";
  #     useOSProber = true;
  #   };
  # };
  time.hardwareClockInLocalTime = true;
  networking.hostName = "sidearm";

  # Enable CUPS to print documents.
  services.printing.enable = true;
  services.nscd = {
    enableNsncd = false;
  };

  # Enable sound with pipewire.
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  services.xserver.videoDrivers = [ "amdgpu" ];

  system.stateVersion = "23.11"; # Did you read the comment?
}
