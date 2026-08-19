{ lib, config, ... }:
{
  imports = [ ];

  home.sessionVariables =
    let
      inherit (config) home programs;
      nvim = home.shellAliases.nvim or (lib.getExe programs.neovim.finalPackage);
    in
    {
      EDITOR = nvim;
      MANPAGER = "${nvim} --cmd 'lua _G.__iron_e_startup_for_manpage = true' +Man!";
    };
}
