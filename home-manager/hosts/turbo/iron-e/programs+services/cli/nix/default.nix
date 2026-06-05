{
  inputs,
  pkgs,
  outputs,
  ...
}:
let
  util = outputs.lib;
in
{
  imports = util.fs.readSubmodules ./.;

  nix.package = inputs.nix.legacyPackages.${pkgs.stdenv.hostPlatform.system}.nix;
}
