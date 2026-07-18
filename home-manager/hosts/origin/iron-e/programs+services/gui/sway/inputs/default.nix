{ outputs, ... }:
let
  util = outputs.lib;
in
{
  imports = util.fs.readSubmodules ./.;

  # From: https://www.reddit.com/r/swaywm/comments/156wsoe/comment/jt3id0x/
  #
  #> It should be possible to do this using a custom keymap. See if the following works:
  #>
  #> Create a my_layout.xkb somewhere.
  #>
  #> ```
  #> xkb_keymap {
  #>     xkb_keycodes { include "evdev+aliases(qwerty)" };
  #>     xkb_types { include "complete" };
  #>     xkb_compat { include "complete" };
  #>     xkb_symbols {
  #>         include "pc"
  #>         include "us"
  #>         include "inet(evdev)"
  #>         replace key <RALT> { [ Super_R ] };
  #>     };
  #> };
  #> ```
  #>
  #> And add in your sway config:
  #>
  #> ```
  #> input type:keyboard {
  #>     xkb_file "PATH/TO/my_layout.xkb"
  #> }
  #> ```

  wayland.windowManager.sway.extraConfig = # i3config
    ''
      input "9639:64097:Compx_2.4G_Receiver_Mouse" {
        accel_profile adaptive
        pointer_accel -0.9
      }

      input "2:7:SynPS/2_Synaptics_TouchPad" {
        pointer_accel 0.8
      }

      input "5824:10203:Glove80_Keyboard" {
        xkb_file "${./external.xkb}"
      }

      input "0:6:Video_Bus" {
        xkb_file "${./builtin.xkb}"
      }

      input "1:1:AT_Translated_Set_2_keyboard" {
        xkb_file "${./builtin.xkb}"
      }

      input "1266:6192:DELL_Alienware_510K" {
        xkb_file "${./normal-external.xkb}"
      }
    '';
}
