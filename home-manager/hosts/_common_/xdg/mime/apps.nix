{
  config,
  lib,
  pkgs,
  ...
}:
{
  imports = [ ];

  xdg.mimeApps = lib.optionalAttrs pkgs.stdenv.isLinux {
    enable = true;
    defaultApplications = lib.optionalAttrs config.programs.librewolf.enable {
      "text/html" = "librewolf.desktop";
    };
  };
}
