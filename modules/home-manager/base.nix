{ ... }:

{
  home = {
    username = "mishow";
    homeDirectory = "/home/mishow";
    stateVersion = "26.05";
  };

  programs.home-manager.enable = true;

  xdg.userDirs = {
    enable = true;
    createDirectories = true;
  };
}
