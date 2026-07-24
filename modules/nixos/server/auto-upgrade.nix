{ ... }:

{
  # Automatic system upgrades for server stability and security
  system.autoUpgrade = {
    enable = true;
    dates = "04:00";
    allowReboot = true;
  };

  # Automatic store garbage collection to keep disk space lean
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 7d";
  };
}
