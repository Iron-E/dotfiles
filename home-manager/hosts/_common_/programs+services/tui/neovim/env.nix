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
      MANPAGER = "${nvim} --cmd 'let g:man = v:true' +Man!";
    };
}
