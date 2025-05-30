{
  pkgs,
  config,
  outputs,
  ...
}:
{
  imports = outputs.lib.fs.readSubmodules ./.;

  services.picom = {
    enable = true;
    package = config.lib.nixgl.wrap pkgs.picom;
  };
}
