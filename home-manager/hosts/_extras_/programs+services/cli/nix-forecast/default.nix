{ pkgs, outputs, ... }:
let
  util = outputs.lib;
in
{
  imports = util.fs.readSubmodules ./.;

  # e.g. nix-forecast -o '.#homeConfigurations.iron-e@origin' --show-missing
  home.packages = with pkgs; [ nix-forecast ];
}
