{ outputs, inputs, ... }:
let
  util = outputs.lib;
in
{
  imports = util.fs.readSubmodules ./.;

  xdg.configFile."yazi/plugins/relative-motions.yazi".source = "${inputs.yazi-relative-motions}";
}
