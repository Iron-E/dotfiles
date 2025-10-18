{ lib, ... }:
{
  imports = [ ];

  programs.yazi.keymap.mgr.prepend_keymap = lib.pipe (lib.range 1 9) [
    (map builtins.toString) # convert 1..9 to strings
    (map (s: {
      # convert to motion mapping
      on = [ s ];
      run = "plugin relative-motions ${s}";
      desc = "Move in ${s} relative steps";
    }))
  ];
}
