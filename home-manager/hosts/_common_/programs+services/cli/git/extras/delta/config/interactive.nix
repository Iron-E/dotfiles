{ ... }:
{
  imports = [ ];

  programs.git.delta.options.interactive = {
    keep-plus-minus-markers = false;
  };
}
