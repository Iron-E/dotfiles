{ ... }:
{
  imports = [ ];

  programs.fish.shellAbbrs = {
    cmd = "command";
    fn = "functions";
    std = "builtins";
  };
}
