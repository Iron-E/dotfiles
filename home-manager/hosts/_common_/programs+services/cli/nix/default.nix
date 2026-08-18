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
    if pkgs.stdenv.hostPlatform.isDarwin then
      inputs.nix.legacyPackages.${pkgs.stdenv.hostPlatform.system}.nix
    else
      pkgs.nix
  );
}
