{
  config,
  pkgs,
  unstable,
  ...
}:

let
  dotfilesDir = "${config.home.homeDirectory}/.config/nixos/dotfiles";
in
{
  programs.home-manager.enable = true;

  home.file = {
    ".tmux.conf".source = config.lib.file.mkOutOfStoreSymlink "${dotfilesDir}/.tmux.conf";
    ".zshrc".source = config.lib.file.mkOutOfStoreSymlink "${dotfilesDir}/.zshrc";
  };

  xdg.configFile = {
    "fastfetch".source = config.lib.file.mkOutOfStoreSymlink "${dotfilesDir}/.config/fastfetch";
    "nvim".source = config.lib.file.mkOutOfStoreSymlink "${dotfilesDir}/.config/nvim";
  };

  home.packages = with pkgs; [
    neovim
    htop
    unstable.antigravity-cli
    vim
    curl
    wl-clipboard
    btop
    nixd
    nil
    # Dev / Ops tools
    clang-tools
    k9s
    kubectl
    kubectx
    fluxcd
  ];

  programs.fastfetch.enable = true;
  programs.bat.enable = true;
  programs.eza.enable = true;
  programs.zoxide.enable = true;
  programs.starship.enable = true;

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
