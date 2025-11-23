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

  programs.brave = {
    enable = true;
    package = config.lib.nixGL.wrap pkgs.brave;
  };
}
