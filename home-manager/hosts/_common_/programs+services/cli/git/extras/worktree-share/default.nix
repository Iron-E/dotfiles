{ outputs, pkgs, ... }:
{
  imports = outputs.lib.fs.readSubmodules ./.;

  home.packages = [ outputs.packages.${pkgs.stdenv.system}.git-worktree-share ];
}
