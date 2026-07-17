{
  config,
  pkgs,
  ...
}:

{
  boot = {
    plymouth.enable = true;
  };

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
  security.pam.services.greetd.fprintAuth = false;
  security.pam.services.greetd.enableGnomeKeyring = true;
  security.pam.services.login.enableGnomeKeyring = true;

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

  # Fonts
  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
  ];

  # Keyring & Polkit
  services.gnome.gnome-keyring.enable = true;
  services.dbus.enable = true;
  security.polkit.enable = true;

  # For networkmanager indicator in bar
  programs.nm-applet.enable = true;
}
