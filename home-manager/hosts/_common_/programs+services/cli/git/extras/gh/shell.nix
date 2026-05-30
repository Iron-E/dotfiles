{ lib, config, ... }:
{
  imports = [ ];

  # because `gh` is short for `git show`
  home.shellAliases.ghub = lib.getExe config.programs.gh.package;
}
