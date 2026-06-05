{ outputs, pkgs, ... }:
let
  util = outputs.lib;
in
{
  imports = util.fs.readSubmodules ./.;

  services.gpg-agent.enable = !pkgs.stdenv.isDarwin;
}
