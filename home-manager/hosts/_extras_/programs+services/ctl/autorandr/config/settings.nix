{ lib, ... }:
{
  imports = [ ];

  xdg.configFile."autorandr/settings.ini".text = lib.generators.toINI { } {
    config = {
      skip-options = "gamma";
    };
  };
}
