{
  inputs,
  pkgs,
  outputs,
  ...
}:
let
  util = outputs.lib;
in
{
  imports = util.fs.readSubmodules ./.;

  home.packages = [ inputs.kzf.packages.${pkgs.system}.default ];
}
