{ pkgs, ... }:

{
  gtk = {
    enable = true;
    iconTheme = {
      name = "Papirus-Dark";
      package = pkgs.papirus-icon-theme;
    };
  };

  services.udiskie.enable = true;

  programs.firefox = {
    enable = true;
    policies = {
      DisableTelemetry = true;
    };
  };
}
