{
  config,
  pkgs,
  inputs,
  unstable,
  ...
}:

{
  imports = [
    # Include the shared system configuration
    ../../nixos/configuration.nix
    # Include the results of the hardware scan
    ./hardware-configuration.nix
  ];

  networking.hostName = "mishlaptop";

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
  powerManagement.enable = true;

  boot = {
    loader.systemd-boot.enable = pkgs.lib.mkForce false;
    lanzaboote = {
      enable = true;
      pkiBundle = "/var/lib/sbctl";
      autoGenerateKeys.enable = true;
      autoEnrollKeys = {
        enable = true;
        # Automatically reboot to enroll the keys in the firmware
        autoReboot = true;
      };
    };
    kernelParams = [
      "quiet"
      "noapic"
      "iommu=pt"
      "lockdown=integrity"
    ];
    kernelPackages = pkgs.linuxPackages_latest;
  };
  environment.systemPackages = [ pkgs.sbctl ];
  hardware.graphics.enable = true;
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
}
