# This is your home-manager configuration file
# Use this to configure your home environment (it replaces ~/.config/nixpkgs/home.nix)
{
  inputs,
  lib,
  config,
  pkgs,
  ...
}: {
  # You can import other home-manager modules here
  imports = [
    # If you want to use modules your own flake exports (from modules/home-manager):
    # inputs.self.homeManagerModules.example

    # Or modules exported from other flakes (such as nix-colors):
    # inputs.nix-colors.homeManagerModules.default

    # You can also split up your configuration and import pieces of it here:
    # ./nvim.nix
  ];

  home = {
    username = "mishow";
    homeDirectory = "/home/mishow";
  };

  # Add stuff for your user as you see fit:
  home.packages = with pkgs; [
    htop
    fastfetch
    nautilus
    stow
    antigravity-cli # Overlayed to unstable in overlays/default.nix
  ];

  # Enable home-manager and git
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

  # Terminal Emulator (Alacritty)
  programs.alacritty = {
    enable = true;
    settings = {
      window = {
        padding = {
          x = 12;
          y = 12;
        };
        dynamic_title = true;
      };
      font = {
        normal = {
          family = "JetBrainsMono Nerd Font";
          style = "Regular";
        };
        size = 11.0;
      };
    };
  };

  # Shell configuration (Zsh)
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    shellAliases = {
      update = "sudo nixos-rebuild switch --flake /home/mishow/nixos-config#nixos";
      ll = "eza -l --icons --git";
      la = "eza -la --icons --git";
      cat = "bat";
      g = "git";
    };
  };

  # Starship prompt
  programs.starship = {
    enable = true;
    enableZshIntegration = true;
  };

  # Bat (modern cat)
  programs.bat = {
    enable = true;
    config = {
      theme = "Visual Studio Dark+";
    };
  };

  # Eza (modern ls)
  programs.eza = {
    enable = true;
    git = true;
    icons = "auto";
  };

  # Zoxide (modern cd)
  programs.zoxide = {
    enable = true;
    enableZshIntegration = true;
  };

  # Neovim
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
  };

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "26.05";
}

