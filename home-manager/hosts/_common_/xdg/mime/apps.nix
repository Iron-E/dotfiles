{ lib, config, ... }:
{
  imports = [ ];

  xdg.mimeApps = {
    enable = true;
    defaultApplications = lib.optionalAttrs config.programs.librewolf.enable {
      "text/html" = "librewolf.desktop";
    };
  };
}
