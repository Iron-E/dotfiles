{ outputs, pkgs, ... }:
let
  util = outputs.lib;
in
{
  imports = util.fs.readSubmodules ./.;

  home.packages = [
    pkgs.which
    (pkgs.writeShellApplication {
      name = "caw";
      text = # sh
        ''
          cat "$(which "$@")"
        '';
    })
  ];
}
