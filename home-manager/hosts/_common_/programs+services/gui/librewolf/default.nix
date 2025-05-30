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

  programs.librewolf = {
    enable = true;
    package = config.lib.nixgl.wrap pkgs.librewolf;
  };
}
