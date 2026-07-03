{
  outputs,
  pkgs,
  lib,
  ...
}:
{
  imports = [ ];

  home.shellAliases = {
    gks = lib.getExe outputs.packages.${pkgs.stdenv.system}.git-worktree-share;
    gksa = "gks add";
    gksh = "gks hook";
    gksl = "gks list";
    gksr = "gks rm";
    gkst = "gks status";
    gksy = "gks sync";
  };
}
