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

    zellij-unwrapped =
      let
        base = prev.zellij-unwrapped.overrideAttrs (
          finalAttrs: prevAttrs: {
            version = "0.46.0";
            src = prevAttrs.src.override {
              hash = "sha256-JpSNWC6jHahirUmnWRZKiVRonFjjIZx9j0V//6t1+iM=";
            };

            cargoDeps = prev.rustPlatform.fetchCargoVendor {
              inherit (finalAttrs) pname version src;
              hash = "sha256-i3Vh7w9YeGUkGIsbqA2UIiLtMqsSC+/ehdSDIfTckM8=";
            };
          }
        );

        runtimeDeps = [
          prev.libGL
          prev.libxkbcommon
          prev.wayland
          prev.fontconfig
        ];

        canRun = prev.stdenv.buildPlatform.canExecute prev.stdenv.hostPlatform;
      in
      prev.symlinkJoin {
        name = "zellij-unwrapped-${base.version}";
        paths = [ base ];

        passthru = (base.passthru or { }) // {
          inherit base;
        };

        inherit (base) pname version meta;
        nativeBuildInputs = prev.lib.optionals prev.stdenv.hostPlatform.isLinux [ prev.patchelf ];

        postBuild = # runs right after the lndir pass
          prev.lib.optionalString prev.stdenv.hostPlatform.isLinux # bash
            ''
              # lndir left bin/zellij as a symlink into the read-only base store path, so patchelf can't patch through it.
              rm $out/bin/zellij
              cp ${base}/bin/zellij $out/bin/zellij
              chmod u+w $out/bin/zellij # cp copies the 555 mode

              patchelf --add-rpath ${prev.lib.makeLibraryPath runtimeDeps} $out/bin/zellij

              # Desktop integration, per upstream PACKAGING_DESKTOP.md.
              install -Dm644 ${base.src}/assets/dev.zellij.Zellij.desktop \
                $out/share/applications/dev.zellij.Zellij.desktop

              for size in 128 256 512; do
                install -Dm644 "${base.src}/zellij-utils/assets/icons/logo''${size}.png" \
                  "$out/share/icons/hicolor/''${size}x''${size}/apps/dev.zellij.Zellij.png"
              done

              install -Dm644 ${base.src}/assets/dev.zellij.Zellij.metainfo.xml \
                $out/share/metainfo/dev.zellij.Zellij.metainfo.xml
            ''
          +
            prev.lib.optionalString (prev.stdenv.hostPlatform.isDarwin && canRun) # bash
              ''
                scratch=$PWD/zellij-desktop-install
                ZELLIJ_DESKTOP_INTEGRATION=on HOME=$scratch \
                  $out/bin/zellij setup --install-desktop-entry

                mkdir -p $out/Applications
                mv $scratch/Applications/Zellij.app $out/Applications/Zellij.app
                rm -rf $scratch
              '';
      };

    vimix-icon-theme-beryl = prev.vimix-icon-theme.override {
      colorVariants = [ "Beryl" ];
    };

    # example = prev.example.overrideAttrs (oldAttrs: rec {
    # ...
    # });
  };
}
