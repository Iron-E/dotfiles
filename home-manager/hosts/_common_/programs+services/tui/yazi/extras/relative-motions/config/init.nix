{ ... }:
{
  imports = [ ];

  xdg.configFile."yazi/init.lua".text = # lua
    ''
      	require('relative-motions'):setup {
      		show_motion = true,
      		show_numbers = 'relative_absolute',
      	};
    '';
}
