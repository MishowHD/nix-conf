{
  config,
  pkgs,
  unstable,
  ...
}:

{
  home = {
    username = "mishow";
    homeDirectory = "/home/mishow";
    stateVersion = "26.05";
  };

  imports = [
    ../modules/home-manager/global.nix
    ../modules/home-manager/desktop.nix
  ];
}
