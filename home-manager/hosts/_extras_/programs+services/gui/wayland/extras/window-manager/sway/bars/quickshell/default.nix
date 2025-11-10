{
  config,
  outputs,
  pkgs,
  ...
}:
let
  util = outputs.lib;
in
{
  imports = util.fs.readSubmodules ./.;

  programs.quickshell = {
    activeConfig = "sway";
    enable = true;
    package = config.lib.nixGL.wrap pkgs.quickshell;
    systemd.enable = true;
  };
}
