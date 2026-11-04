# This file defines overlays
{ nixpkgs-vimix, self, ... }:
let
  util = self.outputs.lib;
in
{
  # Bring custom packages rom the 'pkgs' directory
  additions =
    final: _prev:
    (import ../pkgs {
      inherit util;
      pkgs = final;
    });

  # This one contains whatever you want to overlay
  # You can change versions, add patches, set compilation flags, anything really.
  # https://nixos.wiki/wiki/Overlays
  modifications = _final: prev: {
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

    tuios = prev.tuios.overrideAttrs (
      finalAttrs: prevAttrs: {
        version = "91a743c5a79785766ccb968bda6f022c54950eb8";
        src =
          prevAttrs.src.override {
            hash = "sha256-+l7OY1AfsMTBNnuRELo7NO/NrbM2u+wixpioNvMLlg8=";
            tag = null;
            rev = finalAttrs.version;
          }
          // {
            tag = finalAttrs.version;
          };

        vendorHash = "sha256-j6IiDD4MJ5nRzZa34Mt03L0LI5GG+wY4CrcNldsXwXY=";

        ldflags = [
          "-s"
          "-w"
          "-X=main.version=${finalAttrs.version}"
          "-X=main.commit=${finalAttrs.src.rev}"
          "-X=main.date=1970-01-01T00:00:00Z"
          "-X=main.builtBy=nixpkgs"
        ];

        postPatch = (prevAttrs.postPatch or "") + ''
          go work edit -dropuse=./e2e/tui
        '';

        passthru = prevAttrs.passthru // {
          overrideModAttrs = prev.lib.composeExtensions (prevAttrs.passthru.overrideModAttrs or (_: _: { })) (
            _finalModAttrs: prevModAttrs: {
              buildPhase = ''
                runHook preBuild
                go work vendor
                runHook postBuild
              '';

              # Belt and braces: GOWORK="" means "search for go.work", i.e. workspace mode on.
              env = (prevModAttrs.env or { }) // {
                GOWORK = "";
              };
            }
          );
        };
      }
    );

    vimix-icon-theme-beryl = prev.vimix-icon-theme.override {
      colorVariants = [ "Beryl" ];
    };

    # example = prev.example.overrideAttrs (oldAttrs: rec {
    # ...
    # });
  };
}
