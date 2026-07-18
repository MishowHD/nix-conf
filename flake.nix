{
  description = "NixOS and Home Manager configuration flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    lanzaboote = {
      url = "github:nix-community/lanzaboote/v1.1.0";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixos-hardware = {
      url = "github:NixOS/nixos-hardware";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      self,
      nixpkgs,
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

      mkHost =
        hostName:
        nixpkgs.lib.nixosSystem {
          inherit system;
          specialArgs = { inherit inputs; };
          modules = [
            ./hosts/${hostName}
          ];
        };
    in
    {

      formatter.${system} = pkgs.nixfmt;

      nixosConfigurations = {
        des-01 = mkHost "des-01";
        lap-01 = mkHost "lap-01";
      };
    };
}
