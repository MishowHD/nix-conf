{ ... }:

{
  home = {
    username = "mishow";
    homeDirectory = "/home/mishow";
    stateVersion = "26.05";
  };

  imports = [
    ./global.nix
    ./desktop.nix
  ];
}
