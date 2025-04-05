{ lib, ... }:
{
  imports = [ ];

  programs.librewolf.settings = lib.mapAttrs' (n: lib.nameValuePair "webgl.${n}") {
    disabled = true;
  };
}
