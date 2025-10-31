{ outputs, ... }:
let
  util = outputs.lib;
in
{
  imports = util.fs.readSubmodules ./.;

  wayland.windowManager.sway.extraConfig = # i3config
    ''
      input "9639:64097:Compx_2.4G_Receiver_Mouse" {
        accel_profile adaptive
        pointer_accel -0.3
      }

      input "2:7:SynPS/2_Synaptics_TouchPad" {
        pointer_accel 0.8
      }

      input "5824:10203:Glove80_Keyboard" {
        xkb_file "${./external.xkb}"
      }

      input "1:1:AT_Translated_Set_2_keyboard" {
        xkb_file "${./builtin.xkb}"
      }
    '';
}
