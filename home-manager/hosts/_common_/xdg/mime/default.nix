{ outputs, ... }:
let
  util = outputs.lib;
in
{
  imports = util.fs.readSubmodules ./.;

  # `xdg.mime.enable = true;` already set on linux platforms
}
