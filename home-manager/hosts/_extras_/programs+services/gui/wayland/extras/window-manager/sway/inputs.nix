{ lib, ... }:
{
  imports = [ ];

  wayland.windowManager.sway.extraConfig = # i3config
    lib.mkOrder 750 ''

      input "type:keyboard" {
        xkb_numlock enabled
      }

      input "type:pointer" {
        natural_scroll disabled
      }

      input "type:touchpad" {
        accel_profile adaptive
        clickfinger_button_map lrm
        dwt enabled
        dwtp enabled
        natural_scroll enabled
        scroll_method two_finger
        tap_button_map lrm
      }
    '';
}
