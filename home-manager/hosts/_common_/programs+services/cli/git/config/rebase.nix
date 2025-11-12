{ ... }:
{
  imports = [ ];

  programs.git.settings.rebase = {
    autosquash = true;
    updateRefs = true;
  };
}
