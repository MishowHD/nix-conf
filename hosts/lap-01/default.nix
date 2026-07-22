{ pkgs, inputs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    inputs.nixos-hardware.nixosModules.lenovo-thinkpad-t14-amd-gen5
  ];

  networking.hostName = "lap-01";

  boot = {
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };

    kernelParams = [
      "quiet"
      "splash"
      "amd_iommu=on"
      "lockdown=integrity"
    ];

    kernelPackages = pkgs.linuxPackages_latest;
  };

  # Btrfs mount optimizations
  fileSystems."/".options = [
    "compress=zstd"
    "noatime"
  ];
  fileSystems."/home".options = [
    "compress=zstd"
    "noatime"
  ];
  fileSystems."/nix".options = [
    "compress=zstd"
    "noatime"
  ];
  services.btrfs.autoScrub.enable = true;

  powerManagement.enable = true;
  hardware.graphics.enable = true;
  hardware.alsa.enablePersistence = true;

  services.fprintd.enable = true;
  security.pam.services.ly.fprintAuth = false;

  system.stateVersion = "26.05";
}
