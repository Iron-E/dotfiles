{ ... }:
{
  imports = [ ];

  programs.git.settings.commit = {
    template = "${./message.txt}";
    verbose = true;
  };
}
