{
  config,
  pkgs,
  outputs,
  ...
}:
let
  util = outputs.lib;
in
{
  imports = util.fs.readSubmodules ./.;

  programs.ghostty = {
    enable = true;
    package = if pkgs.stdenv.isDarwin then null else config.lib.nixgl.wrap pkgs.ghostty;
  };
}
