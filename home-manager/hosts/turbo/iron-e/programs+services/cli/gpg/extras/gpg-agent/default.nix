{ lib, outputs, ... }:
let
  util = outputs.lib;
in
{
  imports = util.fs.readSubmodules ./.;

  services.gpg-agent.enable = lib.mkForce false;
}
