{ lib, config, ... }:
let
  inherit (lib) getExe toList;
in
{
  xsession.windowManager.i3.config.startup = toList {
    always = true;
    command = "${getExe config.programs.feh.package} --no-fehbg --bg-fill ${config.xdg.userDirs.pictures}/wallpaper.png";
    notification = false;
  };
}
