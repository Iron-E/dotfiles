{ config, ... }:
{
  imports = [ ];

  programs.gpg.homedir =
    let
      inherit (config) xdg;
    in
    "${xdg.dataHome}/gnupg";
}
