{ lib, ... }:
{
  imports = [ ];

  programs.yazi.keymap.mgr.prepend_keymap = map (i: {
    # convert to motion mapping
    on = [ "<A-${toString (i + 1)}>" ];
    run = "tab_switch ${toString i}";
    desc = "Switch to tab ${toString (i + 1)}";
  }) (lib.range 0 8);
}
