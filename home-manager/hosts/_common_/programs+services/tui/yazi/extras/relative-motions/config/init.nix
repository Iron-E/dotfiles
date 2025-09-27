{ ... }:
{
  imports = [ ];

  programs.yazi.initLua = # lua
    ''
      require('relative-motions'):setup {
        show_motion = true,
        show_numbers = 'relative_absolute',
      };
    '';
}
