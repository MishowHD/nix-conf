{
  description = "NixOS and Home Manager configuration flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-26.05";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager.url = "github:nix-community/home-manager/release-26.05";

    lanzaboote = {
      url = "github:nix-community/lanzaboote/v1.1.0";
    };
  };

  outputs =
    {
      self,
      nixpkgs,
      home-manager,
      lanzaboote,
      ...
    }@inputs:
    let
      system = "x86_64-linux";

      nixpkgsConfig = {
        allowUnfree = true;
      };

      pkgs = import nixpkgs {
        inherit system;
        config = nixpkgsConfig;
      };

      unstable = import inputs.nixpkgs-unstable {
        inherit system;
        config = nixpkgsConfig;
      };
    in
    {

      formatter.${system} = pkgs.nixfmt;

      nixosConfigurations = {
        mishnix = nixpkgs.lib.nixosSystem {
          specialArgs = { inherit inputs unstable; };
          modules = [
            { nixpkgs.pkgs = pkgs; }
            ./hosts/mishnix
            home-manager.nixosModules.home-manager
            lanzaboote.nixosModules.lanzaboote
          ];
        };
        mishlaptop = nixpkgs.lib.nixosSystem {
          specialArgs = { inherit inputs unstable; };
          modules = [
            { nixpkgs.pkgs = pkgs; }
            ./hosts/mishlaptop
            home-manager.nixosModules.home-manager
            lanzaboote.nixosModules.lanzaboote
          ];
        };
      };
    };
}
