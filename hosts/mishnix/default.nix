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

  networking.hostName = "mishnix";

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
}
