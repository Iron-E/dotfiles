# This file defines overlays
{ inputs, ... }:
let
  inherit (inputs.nixpkgs) lib;
  inherit (inputs) nixpkgs-vimix;
in
{
  # Bring custom packages rom the 'pkgs' directory
  additions = final: _prev: (import ../pkgs final);

  # This one contains whatever you want to overlay
  # You can change versions, add patches, set compilation flags, anything really.
  # https://nixos.wiki/wiki/Overlays
  modifications =
    _final: prev:
    {
      vimix-gtk-theme-beryl =
        let
          vimixPkgs = nixpkgs-vimix.legacyPackages.${prev.stdenv.targetPlatform.system};
          result = builtins.tryEval prev.vimix-gtk-themes;
        in
        prev.lib.warnIf result.success "vimix-gtk-themes is back in nixpkgs, nixpkgs-vimix can be removed"
          (if result.success then result.value else vimixPkgs.vimix-gtk-themes).override
          {
            colorVariants = [ "dark" ];
            themeVariants = [ "beryl" ];
          };

      vimix-icon-theme-beryl = prev.vimix-icon-theme.override {
        colorVariants = [ "Beryl" ];
      };

      # example = prev.example.overrideAttrs (oldAttrs: rec {
      # ...
      # });
    }
    // (lib.optionalAttrs prev.stdenv.hostPlatform.isDarwin {
      mise = prev.mise.overrideAttrs (
        _finalAttrs: prevAttrs: {
          checkFlags = prevAttrs.checkFlags ++ [
            "--skip=oci::layer::tests::preserve_metadata_dir_layer_keeps_special_permission_bits"
          ];
        }
      );
    });
}
