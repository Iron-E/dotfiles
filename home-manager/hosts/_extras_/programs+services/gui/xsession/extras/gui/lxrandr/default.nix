{
  pkgs,
  config,
  outputs,
  ...
}:
let
  util = outputs.lib;
in
{
  imports = util.fs.readSubmodules ./.;

  home.packages = [ (config.lib.nixGL.wrap pkgs.lxrandr) ];
}
