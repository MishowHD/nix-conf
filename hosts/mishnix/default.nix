{
  config,
  pkgs,
  inputs,
  unstable,
  ...
}:

{
  imports = [
    # Include the results of the hardware scan
    ./hardware-configuration.nix
    # Include shared modular configurations
    ../../modules/nixos/global.nix
    ../../modules/nixos/desktop.nix
    ../../modules/nixos/secure-boot.nix

    # Include external modules from inputs
    inputs.home-manager.nixosModules.home-manager
    inputs.lanzaboote.nixosModules.lanzaboote
  ];

  networking.hostName = "mishnix";

  # Override options for Btrfs compression (merges with hardware-configuration.nix)
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

  boot = {
    kernelParams = [
      "quiet"
      "noapic"
      "intel_iommu=on"
      "iommu=pt"
      "lockdown=integrity"
    ];
    kernelPackages = pkgs.linuxPackages_latest;
  };

  hardware.graphics.enable = true;
  services.xserver.videoDrivers = [ "nvidia" ];
  hardware.nvidia.open = true;
  hardware.nvidia.modesetting.enable = true;
  services.btrfs.autoScrub.enable = true;

  services.snapper = {
    snapshotInterval = "hourly";
    cleanupInterval = "1d";
    configs = {
      home = {
        SUBVOLUME = "/home";
        ALLOW_USERS = [ "mishow" ];
        TIMELINE_CREATE = true;
        TIMELINE_CLEANUP = true;
        # Quanti snapshot mantenere:
        TIMELINE_LIMIT_HOURLY = "5";
        TIMELINE_LIMIT_DAILY = "7";
        TIMELINE_LIMIT_WEEKLY = "4";
        TIMELINE_LIMIT_MONTHLY = "0";
        TIMELINE_LIMIT_YEARLY = "0";
      };
    };
  };

  system.stateVersion = "26.05";
}
