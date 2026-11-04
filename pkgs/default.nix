# Custom packages, that can be defined similarly to ones from nixpkgs
# You can build them using 'nix build .#example'
{ pkgs, util, ... }:
let
  inherit (pkgs) callPackage;
in
util.fs.genSubmoduleAttrs ./. (module: callPackage module { })
