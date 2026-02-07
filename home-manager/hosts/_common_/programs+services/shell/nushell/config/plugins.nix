{ pkgs, ... }:
{
  imports = [ ];

  programs.nushell.plugins = with pkgs.nushellPlugins; [
    formats
    polars
  ];
}
