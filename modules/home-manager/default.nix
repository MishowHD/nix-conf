{ lib, ... }:

{
  # Automatically import all .nix files in this directory (except default.nix)
  imports =
    let
      files = builtins.readDir ./.;
      nixFiles = lib.filterAttrs (
        name: type:
        type == "regular" && lib.hasSuffix ".nix" name && name != "default.nix"
      ) files;
    in
    builtins.map (name: ./. + "/${name}") (builtins.attrNames nixFiles);
}
