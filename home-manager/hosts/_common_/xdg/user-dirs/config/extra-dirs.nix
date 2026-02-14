{ config, ... }:
{
  imports = [ ];

  xdg.userDirs.extraConfig = {
    BIN = "${config.home.homeDirectory}/.local/bin";
  };

  home.sessionPath = with config.xdg.userDirs.extraConfig; [
    BIN
  ];
}
