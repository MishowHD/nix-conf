{ ... }:

{
  networking = {
    networkmanager.enable = true;
    firewall.enable = true;
    nftables.enable = true;
  };

  services.resolved.enable = true;
  services.tailscale.enable = true;
}
