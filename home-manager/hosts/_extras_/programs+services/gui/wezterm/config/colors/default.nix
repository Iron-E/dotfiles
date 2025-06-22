{ lib, ... }:
let
  inherit (builtins) fromTOML readFile getAttr;

  getColorsFromTOML = lib.flip lib.pipe [
    fromTOML
    (getAttr "colors")
  ];
in
{
  imports = [ ];

  programs.wezterm.colorSchemes = {
    highlite = lib.pipe ./highlite.toml [
      readFile
      getColorsFromTOML
    ];
  };
}
