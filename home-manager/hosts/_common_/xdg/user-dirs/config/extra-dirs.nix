{ config, ... }:
{
  imports = [ ];

  xdg.userDirs.extraConfig = {
    XDG_BIN_DIR = "${config.home.homeDirectory}/.local/bin";
  };

  home.sessionPath = with config.xdg.userDirs.extraConfig; [
    XDG_BIN_DIR
  ];
}
