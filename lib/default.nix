{ inputs }:

let
  inherit (inputs.nixpkgs) lib;
in
{
  # Helper to build a NixOS system configuration for a host in hosts/<hostName>
  # Automatically imports base modules from modules/nixos
  # Accepts either a string (hostName) or an attrset with options:
  # { hostName, system ? "x86_64-linux", specialArgs ? {}, modules ? [] }
  mkHost =
    host:
    let
      args = if builtins.isString host then { hostName = host; } else host;
      hostName = args.hostName;
      system = args.system or "x86_64-linux";
      specialArgs = args.specialArgs or { };
      extraModules = args.modules or [ ];
    in
    lib.nixosSystem {
      inherit system;
      specialArgs = { inherit inputs; } // specialArgs;
      modules = [
        ../modules/nixos
        (../hosts + "/${hostName}")
      ] ++ extraModules;
    };
}
