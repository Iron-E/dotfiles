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

  programs.zathura = {
    enable = true;
    package = config.lib.nixGL.wrap pkgs.zathura;
  };
}
