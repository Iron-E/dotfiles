# This file defines overlays
{ ... }:
{
  # This one brings our custom packages from the 'pkgs' directory
  additions = final: _prev: import ../pkgs final;

  # This one contains whatever you want to overlay
  # You can change versions, add patches, set compilation flags, anything really.
  # https://nixos.wiki/wiki/Overlays
  modifications =
    final: prev:
    let
      vimix-icon = variant: prev.vimix-icon-theme.override { colorVariants = [ variant ]; };
      vimix-theme =
        variant:
        prev.vimix-gtk-themes.override {
          colorVariants = [ "dark" ];
          themeVariants = [ variant ];
        };
    in
    {
      vimix-gtk-theme-beryl = vimix-theme "beryl";
      vimix-icon-theme-beryl = vimix-icon "Beryl";

      # example = prev.example.overrideAttrs (oldAttrs: rec {
      # ...
      # });
    };
}
