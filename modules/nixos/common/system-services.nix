{ ... }:

{
  services.fwupd.enable = true;
  services.upower.enable = true;
  services.gvfs.enable = true;
  services.udisks2.enable = true;
  services.dbus.enable = true;

  zramSwap.enable = true;
  programs.gnupg.agent.enable = true;
  security.polkit.enable = true;
}
