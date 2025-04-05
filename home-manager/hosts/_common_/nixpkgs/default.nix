{ inputs, outputs, ... }:
let
  util = outputs.lib;
in
{
  imports = util.fs.readSubmodules ./.;

  nixpkgs =
    outputs.lib.config.nixpkgs
      (with inputs; [
        # neovim-nightly-overlay
        nixgl
      ])
      (with outputs.overlays; [
        additions
        modifications
      ])
      { };
}
