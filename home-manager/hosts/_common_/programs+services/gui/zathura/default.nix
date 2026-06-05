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
    enable = !pkgs.stdenv.isDarwin;
    package = config.lib.nixGL.wrap pkgs.zathura;
  };
}
