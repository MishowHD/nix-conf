{ pkgs, ... }:

{
  home.packages = with pkgs; [
    # CLI & System Utilities
    neovim
    vim
    htop
    btop
    curl
    wl-clipboard
    fzf
    antigravity-cli
    nixd
    nil

    # Dev & Ops Tools
    clang-tools
    k9s
    kubectl
    kubectx
    fluxcd
    gh

    # Desktop Applications & GUI
    alacritty
    nautilus
    zed-editor
    spotify
    discord
    seahorse
    xwayland-satellite
    papers
  ];
}
