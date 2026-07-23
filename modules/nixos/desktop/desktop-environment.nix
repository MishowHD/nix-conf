{ ... }:

{
  programs.niri.enable = true;
  programs.dms-shell.enable = true;

  services.displayManager.dms-greeter = {
    enable = true;
    compositor.name = "niri";
    configHome = "/home/mishow";
    configFiles = [
      "/home/mishow/.config/DankMaterialShell/settings.json"
    ];
  };

  security.pam.services.greetd = {
    fprintAuth = false;
    enableGnomeKeyring = true;
  };

  services.gnome.gnome-keyring.enable = true;
}
