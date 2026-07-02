{ config, pkgs, inputs, unstable, ... }:

{
  imports = [
    # Include the shared system configuration
    ../../nixos/configuration.nix
    # Include the results of the hardware scan
    ./hardware-configuration.nix
  ];

  networking.hostName = "mishnix";

  boot = {
    kernelParams = [
      "quiet"
      "noapic"
    ];
    kernelPackages = pkgs.linuxPackages_latest;
  };
}
