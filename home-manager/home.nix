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

  xdg.configFile = {
    "niri".source =
      config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.dotfiles/.config/niri";
    "alacritty".source =
      config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.dotfiles/.config/alacritty";
    "fastfetch".source =
      config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.dotfiles/.config/fastfetch";
    "nvim".source =
      config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.dotfiles/.config/nvim";
    "DankMaterialShell".source =
      config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.dotfiles/.config/DankMaterialShell";
    "git/commit-template".source =
      config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.dotfiles/.config/git/commit-template";
  };

  home.file = {
    ".tmux.conf".source =
      config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.dotfiles/.tmux.conf";
    ".zshrc".source =
      config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.dotfiles/.zshrc";
  };

  home.packages = with pkgs; [
    alacritty
    nautilus
    nixd
    stow
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

  home.shellAliases = {
    update = "sudo nixos-rebuild switch --flake \"/home/mishow/.config/nixos#$(hostname)\"";
  };
}
