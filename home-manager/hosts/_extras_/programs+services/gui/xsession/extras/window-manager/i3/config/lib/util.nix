{ lib, config, ... }:
{
  i3Exe = lib.getExe' config.xsession.windowManager.i3.package;
}
