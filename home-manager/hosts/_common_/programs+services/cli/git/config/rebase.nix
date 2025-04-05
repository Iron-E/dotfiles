{ ... }:
{
  imports = [ ];

  programs.git.extraConfig.rebase = {
    autosquash = true;
    updateRefs = true;
  };
}
