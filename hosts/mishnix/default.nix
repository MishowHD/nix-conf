{
  config,
  pkgs,
  inputs,
  unstable,
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
  ];

  # Hostname configuration
  networking.hostName = "mishnix";

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
      "noapic"
      "intel_iommu=on"
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

  # Graphics settings
  hardware.graphics.enable = true;

  # Nvidia drivers
  services.xserver.videoDrivers = [ "nvidia" ];
  hardware.nvidia = {
    open = true;
    modesetting.enable = true;
  };

  # Btrfs automatic scrubbing
  services.btrfs.autoScrub.enable = true;

  # TODO
  #services.snapper = {
  #  snapshotInterval = "hourly";
  #  cleanupInterval = "1d";
  #  configs = {
  #    home = {
  #      SUBVOLUME = "/home";
  #      ALLOW_USERS = [ "mishow" ];
  #      TIMELINE_CREATE = true;
  #      TIMELINE_CLEANUP = true;
  #      # Quanti snapshot mantenere:
  #      TIMELINE_LIMIT_HOURLY = "5";
  #      TIMELINE_LIMIT_DAILY = "7";
  #      TIMELINE_LIMIT_WEEKLY = "4";
  #      TIMELINE_LIMIT_MONTHLY = "0";
  #      TIMELINE_LIMIT_YEARLY = "0";
  #    };
  #  #  };
  #};

  system.stateVersion = "26.05";
}
