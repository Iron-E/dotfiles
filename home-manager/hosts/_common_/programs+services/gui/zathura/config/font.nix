{ config, lib, ... }:
{
  imports = [ ];

  programs.zathura.options.font =
    let
      font = lib.pipe config.fonts.fontconfig.defaultFonts.sansSerif [
        builtins.head
        lib.strings.toLower
      ];
    in
    "${font} 16";
}
