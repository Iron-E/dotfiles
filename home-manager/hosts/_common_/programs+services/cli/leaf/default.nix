{ outputs, pkgs, ... }:
{
  imports = outputs.lib.fs.readSubmodules ./.;

  home.packages = with pkgs; [ leaf ];
}
