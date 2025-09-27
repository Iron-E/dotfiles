{ pkgs, config, ... }:
{
  imports = [ ../../../programs+services/gui/gtk/config/font.nix ];

  home.packages = with pkgs; [
    config.gtk.font.package
    jetbrains-mono
    nerd-fonts.symbols-only
  ];

  fonts.fontconfig.defaultFonts = {
    monospace = [
      "JetBrains Mono"
      "Symbols Nerd Font Mono"
    ];
    serif = [
      config.gtk.font.name
      "Symbols Nerd Font Mono"
    ];
    sansSerif = config.fonts.fontconfig.defaultFonts.serif;
  };
}
