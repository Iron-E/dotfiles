{ inputs, outputs, ... }:
let
  util = outputs.lib;
in
{
  imports = util.fs.readSubmodules ./.;

  nixpkgs =
    outputs.lib.config.nixpkgs # <- to prevent bad formatting
      [ ] # <- overlays from inputs (e.g. `(with inputs; [ my-overlay ])`)
      (with outputs.overlays; [
        additions
        modifications
      ])
      { };
}
