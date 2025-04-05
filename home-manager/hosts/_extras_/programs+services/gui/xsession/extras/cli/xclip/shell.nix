{ ... }:
{
  imports = [ ];

  home.shellAliases = {
    P = "xclip -o -selection clipboard";
    Y = "xclip -i -selection clipboard";
  };
}
