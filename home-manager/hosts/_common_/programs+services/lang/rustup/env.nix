{ pkgs, config, ... }:
{
  imports = [ ];

  home =
    let
      inherit (config) xdg;
      inherit (pkgs.stdenv) hostPlatform;
    in
    {
      sessionVariables.RUSTUP_HOME = "${xdg.dataHome}/rustup";
      sessionSearchVariables.PATH = [
        "${config.home.sessionVariables.RUSTUP_HOME}/toolchains/stable-${hostPlatform.config}/bin"
      ];
    };
}
