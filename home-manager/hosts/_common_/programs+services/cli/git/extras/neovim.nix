{ lib, config, ... }:
{
  imports = [ ];

  programs = {
    neovim.enable = true;

    git.extraConfig = {
      core.editor = lib.getExe config.programs.neovim.finalPackage;
      diff.tool = "nvim";
      merge.tool = "nvimdiff";
      mergetool =
        let
          nvimdiff.layout = "LOCAL,REMOTE / MERGED";
        in
        {
          inherit nvimdiff;

          # HACK: until git 2.45. See git/git#b21d164275b9186421ebe39498be47ea9f171694
          vimdiff = nvimdiff;
        };
    };
  };
}
