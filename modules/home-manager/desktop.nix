{
  config,
  pkgs,
  ...
}:

let
  dotfilesDir = "${config.home.homeDirectory}/.config/nixos/dotfiles";
in
{
  xdg.userDirs = {
    enable = true;
    createDirectories = true;
  };

  xdg.configFile = {
    "niri".source = config.lib.file.mkOutOfStoreSymlink "${dotfilesDir}/.config/niri";
    "alacritty".source = config.lib.file.mkOutOfStoreSymlink "${dotfilesDir}/.config/alacritty";
    "DankMaterialShell".source =
      config.lib.file.mkOutOfStoreSymlink "${dotfilesDir}/.config/DankMaterialShell";
  };

  home.packages = with pkgs; [
    alacritty
    nautilus
    zed-editor
    spotify
    discord
    seahorse
    xwayland-satellite
    papers
  ];

  gtk = {
    enable = true;
    iconTheme = {
      name = "Papirus-Dark";
      package = pkgs.papirus-icon-theme;
    };
  };

  services.udiskie = {
    enable = true;
  };

  programs.firefox.enable = true;
}
