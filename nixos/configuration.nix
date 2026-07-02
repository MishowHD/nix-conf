# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, inputs, ... }:

{
  # =========================================================================
  # 📂 IMPORTS & HARDWARE
  # =========================================================================
  imports = [
    ./hardware-configuration.nix
  ];

  # =========================================================================
  # 🚀 BOOTLOADER & KERNEL
  # =========================================================================
  boot = {
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
    kernelParams = [
      "quiet"
      "noapic"
    ];
    kernelPackages = pkgs.linuxPackages_latest;
  };

  # =========================================================================
  # 🌐 NETWORKING & LOCALIZATION
  # =========================================================================
  networking = {
     hostName = "mishnix";
     networkmanager.enable = true;
  };

  time.timeZone = "Europe/Rome";

  i18n = {
    defaultLocale = "en_US.UTF-8";
    extraLocaleSettings = {
      LC_ADDRESS = "en_US.UTF-8";
      LC_IDENTIFICATION = "en_US.UTF-8";
      LC_MEASUREMENT = "en_US.UTF-8";
      LC_MONETARY = "en_US.UTF-8";
      LC_NAME = "en_US.UTF-8";
      LC_NUMERIC = "en_US.UTF-8";
      LC_PAPER = "en_US.UTF-8";
      LC_TELEPHONE = "en_US.UTF-8";
      LC_TIME = "en_US.UTF-8";
    };
  };

  # =========================================================================
  # 🖥️ DESKTOP ENVIRONMENT & SERVICES
  # =========================================================================
  services.displayManager.ly.enable = true;
  programs.niri.enable = true;
  programs.dms-shell.enable = true;
  programs.firefox.enable = true;

  # Hardware enablement services
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = false;
  };
  services.printing.enable = true;

  # Sound settings (PipeWire)
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  # =========================================================================
  # 👤 USER CONFIGURATION & SHELL
  # =========================================================================
  users.users.mishow = {
    isNormalUser = true;
    description = "Giacomo Di Clerico";
    extraGroups = [ "networkmanager" "wheel" ];
    shell = pkgs.zsh;
  };

  programs.zsh.enable = true;

  # =========================================================================
  # 📦 SYSTEM PACKAGES & FONTS
  # =========================================================================
  environment.systemPackages = with pkgs; [
    vim   # Always keep a terminal editor in the system profile
    git   # Core VCS
    curl  # Network downloads
    procps # Process monitoring utilities
  ];

  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
  ];

  # =========================================================================
  # ❄️ NIX SYSTEM SETTINGS & GARBAGE COLLECTION
  # =========================================================================
  nix = {
    settings = {
      experimental-features = [ "nix-command" "flakes" ];
      auto-optimise-store = true; # Deduplicate files to save space
    };
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };
  };

  # Nixpkgs config & overlays
  nixpkgs = {
    overlays = [
      inputs.self.overlays.additions
      inputs.self.overlays.modifications
      inputs.self.overlays.unstable-packages
    ];
    config.allowUnfree = true;
  };

  # =========================================================================
  # 🏠 HOME MANAGER INTEGRATION
  # =========================================================================
  home-manager = {
    extraSpecialArgs = { inherit inputs; };
    useGlobalPkgs = true;
    useUserPackages = true;
    users.mishow = import ../home-manager/home.nix;
  };

  # =========================================================================
  # 📌 STATE VERSION (DO NOT CHANGE)
  # =========================================================================
  system.stateVersion = "26.05";
}
