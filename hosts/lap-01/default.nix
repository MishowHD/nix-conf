{
  config,
  pkgs,
  inputs,
  stable,
  ...
}:

{
  imports = [
    # Hardware scan results
    ./hardware-configuration.nix

    # Shared NixOS modules
    ../../modules/nixos/global.nix
    ../../modules/nixos/desktop.nix
    ../../modules/nixos/secure-boot.nix
    ../../modules/nixos/home-manager.nix

    # ThinkPad T14 AMD Gen 5 hardware module
    inputs.nixos-hardware.nixosModules.lenovo-thinkpad-t14-amd-gen5
  ];

  # Hostname configuration
  networking.hostName = "lap-01";

  # Local user configuration
  home-manager.users.mishow = import ./home.nix;

  boot = {
    # EFI bootloader
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };

    # Kernel parameters
    kernelParams = [
      "quiet"
      "splash"
      "amd_iommu=on"
      "lockdown=integrity"
    ];

    # Kernel package version
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

  # Laptop power management
  powerManagement.enable = true;

  # Hardware settings
  hardware.graphics.enable = true;
  hardware.alsa.enablePersistence = true;

  # Fingerprint reader settings
  services.fprintd.enable = true;
  security.pam.services.ly.fprintAuth = false;

  # Btrfs automatic scrubbing
  services.btrfs.autoScrub.enable = true;

  system.stateVersion = "26.05";
}
