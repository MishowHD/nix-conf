{ config, pkgs, ... }:

{
  # =========================================================================
  # 🏠 HOME MANAGER PROFILE
  # =========================================================================
  home = {
    username = "mishow";
    homeDirectory = "/home/mishow";
    stateVersion = "26.05";
  };

  # =========================================================================
  # 🔗 SYMLINK DOTFILES (Using mkOutOfStoreSymlink for instant edits)
  # =========================================================================
  xdg.configFile = {
    "niri".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.dotfiles/.config/niri";
    "alacritty".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.dotfiles/.config/alacritty";
    "fastfetch".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.dotfiles/.config/fastfetch";
    "nvim".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.dotfiles/.config/nvim";
    "DankMaterialShell".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.dotfiles/.config/DankMaterialShell";
    "git/commit-template".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.dotfiles/.config/git/commit-template";
  };

  home.file = {
    ".tmux.conf".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.dotfiles/.tmux.conf";
    ".zshrc".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.dotfiles/.zshrc";
  };

  # =========================================================================
  # 📦 USER-LEVEL PACKAGES
  # =========================================================================
  home.packages = with pkgs; [
    # Desktop & Terminal Apps
    alacritty
    nautilus
    stow
    neovim
    zed-editor
    
    # Modern CLI Utilities
    htop
    fastfetch
    bat
    eza
    zoxide
    starship
    
    # AI Development Platform
    antigravity-cli # Traced to unstable nixpkgs via overlay
  ];

  # =========================================================================
  # 🛠️ PROGRAMS CONFIGURED VIA NIX
  # =========================================================================
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

  home.shellAliases = {
    update = "sudo nixos-rebuild switch --flake ~/nixos-config#mishnix";
  };
}

