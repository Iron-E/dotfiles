{ pkgs, lib, ... }:
{
  imports = [ ];

  home.packages = with pkgs.nerd-fonts; [
    jetbrains-mono # monospace font
    open-dyslexic # (sans) serif font
  ];

  programs.librewolf.settings = lib.mapAttrs' (n: lib.nameValuePair "font.${n}") {
    "minimum-size.x-western" = 18;
    "name.monospace.x-western" = "JetBrainsMono Nerd Font Mono";
    "name.sans-serif.x-western" = "OpenDyslexic Nerd Font";
    "name.serif.x-western" = "OpenDyslexic Nerd Font";
    "size.monospace.x-western" = 14;
    "size.variable.x-western" = 18;
  };
}
