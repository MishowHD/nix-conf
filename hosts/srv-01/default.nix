{ ... }:

{
  imports = [
    ./hardware-configuration.nix
  ];

  networking.hostName = "kube";

  # Standard UEFI bootloader for Proxmox / VM / Bare-metal
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  system.stateVersion = "26.05";
}
