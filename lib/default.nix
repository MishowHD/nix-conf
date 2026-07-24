{ inputs }:

let
  inherit (inputs.nixpkgs) lib;

  # Core helper to build a NixOS system configuration
  mkSystem =
    {
      host,
      isServer ? false,
      pkgsInput ? (if isServer && (inputs ? nixpkgs-stable) then inputs.nixpkgs-stable else inputs.nixpkgs),
      specialArgs ? { },
      modules ? [ ],
    }:
    let
      args = if builtins.isString host then { hostName = host; } else host;
      hostName = args.hostName;
      system = args.system or "x86_64-linux";
      extraModules = (args.modules or [ ]) ++ modules;
      nixosLib = pkgsInput.lib;
    in
    nixosLib.nixosSystem {
      inherit system;
      specialArgs = { inherit inputs hostName; } // specialArgs;
      modules = [
        ../modules/nixos/common
      ]
      ++ (if inputs ? disko then [ inputs.disko.nixosModules.disko ] else [ ])
      ++ (if isServer then [ ../modules/nixos/server ] else [ ../modules/nixos/desktop ])
      ++ [ (../hosts + "/${hostName}") ]
      ++ extraModules;
    };
in
{
  inherit mkSystem;

  # Fallback helper
  mkHost = host: mkSystem { inherit host; };

  # Specialized helper for Desktop / Laptop systems (unstable pkgs, Home Manager, GUI)
  mkDesktop = host: mkSystem (if builtins.isString host then { inherit host; isServer = false; } else host // { isServer = false; });

  # Specialized helper for Server systems (stable pkgs, no Home Manager, auto-upgrade, lean)
  mkServer = host: mkSystem (if builtins.isString host then { inherit host; isServer = true; } else host // { isServer = true; });
}
