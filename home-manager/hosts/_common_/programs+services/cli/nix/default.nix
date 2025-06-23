{
  lib,
  pkgs,
  inputs,
  outputs,
  ...
}:
let
  util = outputs.lib;
in
{
  imports = util.fs.readSubmodules ./.;

  nix.package = lib.mkDefault (
    if pkgs.stdenv.isDarwin then inputs.nix.legacyPackages.${pkgs.system}.nix else pkgs.nix
  );
}
