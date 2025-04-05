{
  outputs,
  config,
  lib,
  ...
}:
let
  util = outputs.lib;
in
{
  imports = util.fs.readSubmodules ./.;

  home.activation.linkXsessionToXinitrc = # link xsession with xinit so that startx works
    let
      inherit (config.home) homeDirectory;
      inherit (config.xsession) scriptPath;
    in
    lib.hm.dag.entryAfter [ "linkGeneration" ] # sh
      ''
        run ln -sf ${homeDirectory}/${scriptPath} ${homeDirectory}/.xinitrc
      '';
}
