{
  config,
  lib,
  outputs,
  ...
}:
let
  util = outputs.lib;
in
{
  imports = util.fs.readSubmodules ./.;

  programs.delta.options = {
    navigate = true;
    line-numbers = true;
    syntax-theme = # try to get the bat theme, falling back to `DarkNeon`
      lib.attrByPath [ "programs" "bat" "config" "theme" ] "DarkNeon" config;

    interactive = {
      keep-plus-minus-markers = false;
    };
  };
}
