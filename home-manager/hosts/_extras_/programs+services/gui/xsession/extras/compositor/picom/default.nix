{
  pkgs,
  config,
  outputs,
  ...
}:
{
  imports = outputs.lib.fs.readSubmodules ./.;

  services.picom = {
    enable = false;
    package = config.lib.nixGL.wrap pkgs.picom;
  };
}
