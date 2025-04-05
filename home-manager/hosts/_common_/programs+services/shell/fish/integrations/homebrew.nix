{ pkgs, lib, ... }:
{
  imports = [ ];

  programs.fish.shellInit =
    lib.optionalString pkgs.stdenv.isDarwin # fish
      ''
        if command -qs brew # homebrew is installed
          brew shellenv | source
        end
      '';
}
