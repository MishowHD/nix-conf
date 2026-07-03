{
  config,
  pkgs,
  unstable,
  ...
}:

let
  # Modifica questo percorso se decidi di spostare la cartella nixos altrove.
  # Questo mantiene i file scrivibili (necessario per matugen e dankmaterialshell).
  dotfilesDir = "${config.home.homeDirectory}/.config/nixos/dotfiles";
in
{
  home = {
    username = "mishow";
    homeDirectory = "/home/mishow";
    stateVersion = "26.05";
  };

  xdg.configFile = {
    "niri".source =
      config.lib.file.mkOutOfStoreSymlink "${dotfilesDir}/.config/niri";
    "alacritty".source =
      config.lib.file.mkOutOfStoreSymlink "${dotfilesDir}/.config/alacritty";
    "fastfetch".source =
      config.lib.file.mkOutOfStoreSymlink "${dotfilesDir}/.config/fastfetch";
    "nvim".source =
      config.lib.file.mkOutOfStoreSymlink "${dotfilesDir}/.config/nvim";
    "DankMaterialShell".source =
      config.lib.file.mkOutOfStoreSymlink "${dotfilesDir}/.config/DankMaterialShell";
  };

  home.file = {
    ".tmux.conf".source =
      config.lib.file.mkOutOfStoreSymlink "${dotfilesDir}/.tmux.conf";
    ".zshrc".source =
      config.lib.file.mkOutOfStoreSymlink "${dotfilesDir}/.zshrc";
  };

  home.packages = with pkgs; [
    alacritty
    nautilus
    nixd
    neovim
    zed-editor
    htop
    fastfetch
    bat
    eza
    zoxide
    starship
    unstable.antigravity-cli
    vim
    curl
    nil
  ];

  programs.home-manager.enable = true;

  # Git config
  programs.git = {
    enable = true;
    settings = {
      user = {
        name = "Giacomo Di Clerico";
        email = "giacomodiclerico@gmail.com";
      };
      init = {
        defaultBranch = "main";
      };
    };
  };
}
