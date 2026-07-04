{
  description = "NixOS and Home Manager configuration flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-26.05";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager.url = "github:nix-community/home-manager/release-26.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs =
    {
      self,
      nixpkgs,
      home-manager,
      ...
    }@inputs:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
      unstable = import inputs.nixpkgs-unstable {
        inherit system;
        config.allowUnfree = true;
      };
    in
    {
      packages.${system} = import ./pkgs pkgs;

      formatter.${system} = pkgs.nixfmt;

      nixosModules = import ./modules/nixos;

      nixosConfigurations = {
        mishnix = nixpkgs.lib.nixosSystem {
          specialArgs = { inherit inputs unstable; };
          modules = [
            ./hosts/mishnix
            home-manager.nixosModules.home-manager
          ];
        };
      };
    };
}
