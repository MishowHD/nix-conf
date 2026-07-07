{
  config,
  pkgs,
  ...
}:

{
  boot = {
    plymouth.enable = true;
  };

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

  # Fonts
  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
  ];

  services.gnome.gnome-keyring.enable = true;
  
  # For networkmanager indicator in bar
  programs.nm-applet.enable = true;
}
