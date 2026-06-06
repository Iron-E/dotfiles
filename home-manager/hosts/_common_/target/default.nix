{
  lib,
  inputs,
  outputs,
  pkgs,
  isNixOS ? false,
  ...
}:
let
  util = outputs.lib;
in
{
  imports = util.fs.readSubmodules ./.;

  targets = {
    genericLinux = lib.optionalAttrs (pkgs.stdenv.isLinux && !isNixOS) {
      enable = true;
      nixGL.packages = inputs.nixgl.packages;
    };

    darwin = lib.optionalAttrs pkgs.stdenv.isDarwin {
      copyApps.enable = false;
      linkApps.enable = true;
      search = "DuckDuckGo";
      defaults.NSGlobalDomain = {
        AppleShowAllExtensions = true;
        AppleICUForce24HourTime = true;
        AppleInterfaceStyle = "Dark";
        AppleScrollerPagingBehavior = true;
        AppleShowAllFiles = true;
        NSAutomaticCapitalizationEnabled = false;
        NSAutomaticQuoteSubstitutionEnabled = false;
        NSDocumentSaveNewDocumentsToCloud = false;
        NSWindowShouldDragOnGesture = true;
        "com.apple.keyboard.fnState" = true;
      };
    };
  };
}
