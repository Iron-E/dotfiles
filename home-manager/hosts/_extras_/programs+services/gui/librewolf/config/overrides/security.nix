{ lib, ... }:
{
  imports = [ ];

  programs.librewolf.settings = lib.mapAttrs' (n: lib.nameValuePair "security.${n}") {
    "disable_button.openCertManager" = false;
    "disable_button.openDeviceManager" = false;
  };
}
