{
  config,
  pkgs,
  stable,
  ...
}:

{
  home = {
    username = "mishow";
    homeDirectory = "/home/mishow";
    stateVersion = "26.05";
  };

  imports = [
    ../../modules/home-manager/global.nix
    ../../modules/home-manager/desktop.nix
  ];

  # Host-specific Home Manager settings for des-01 can go here
}
