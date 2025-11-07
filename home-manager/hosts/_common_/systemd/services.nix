{ config, lib, ... }:
{
  imports = [ ];

  # HACK: see https://github.com/nix-community/home-manager/pull/4990
  home.activation.symlinkSystemdUnits =
    let
      fromDir = "${config.home.profileDirectory}/share/systemd/user";
      toDir = "${config.xdg.configHome}/systemd/user";
    in
    lib.hm.dag.entryBetween [ "reloadSystemd" ] [ "onFilesChange" ] # sh
      ''
        if [ -d "${fromDir}" ]; then
          run find "${fromDir}" -type l -exec sh -c '
            ln -sf {} "${toDir}/$(basename {})"
          ' \;
        fi
      '';
}
