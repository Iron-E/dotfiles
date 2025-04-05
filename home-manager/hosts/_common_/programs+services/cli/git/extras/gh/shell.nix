{ lib, config, ... }:
{
  imports = [ ];

  # because `gh` is short for `git show`
  home.shellAliases.github = lib.getExe config.programs.gh.package;
}
