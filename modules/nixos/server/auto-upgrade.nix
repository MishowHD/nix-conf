{ ... }:

{
  # Automatic system upgrades for server stability and security
  system.autoUpgrade = {
    enable = true;
    dates = "04:00";
    randomizedDelaySec = "0s"; # Disable random delay (executes exactly at 04:00)
    allowReboot = false; # Set to true if you want automatic reboots after kernel updates
  };

  # Automatic store garbage collection to keep disk space lean
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 7d";
  };
}
