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
    { self, nixpkgs, ... }@inputs:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};

      customLib = import ./lib { inherit inputs; };
    in
    {
      lib = customLib;

      formatter.${system} = pkgs.nixfmt;

      nixosConfigurations = {
        des-01 = customLib.mkHost "des-01";
        lap-01 = customLib.mkHost "lap-01";
      };
    };
}
