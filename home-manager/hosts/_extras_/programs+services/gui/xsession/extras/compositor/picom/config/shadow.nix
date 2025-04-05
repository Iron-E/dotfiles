{ ... }:
{
  imports = [ ];

  services.picom = {
    # Enabled client-side shadows on windows.
    shadow = true;

    # The blur radius for shadows. (default 12)
    settings.shadow-radius = 7;

    # The x-and-y-axis offsets for shadows. (default [-15 -15])
    shadowOffsets = [
      (-7)
      (-7)
    ];

    # The translucency for shadows. (default .75)
    shadowOpacity = 0.7;

    # The shadow exclude options are helpful if you have shadows enabled. Due to the way picom draws its shadows, certain applications will have visual glitches
    # (most applications are fine, only apps that do weird things with xshapes or argb are affected).
    # This list includes all the affected apps I found in my testing. The "! name~=''" part excludes shadows on any "Unknown" windows, this prevents a visual glitch with the XFWM alt tab switcher.
    shadowExclude = [
      "! name~=''"
      "name = 'Notification'"
      "name = 'Plank'"
      "name = 'Docky'"
      "name = 'Kupfer'"
      "name = 'xfce4-notifyd'"
      "name *= 'VLC'"
      "name *= 'compton'"
      "name *= 'picom'"
      "name *= 'Chromium'"
      "name *= 'Chrome'"
      "class_g = 'Firefox' && argb"
      "class_g = 'Conky'"
      "class_g = 'Kupfer'"
      "class_g = 'Synapse'"
      "class_g ?= 'Lxterminal'"
      "class_g ?= 'Cairo-dock'"
      "class_g ?= 'Notify-osd'"
      "class_g ?= 'Xfce4-notifyd'"
      "class_g ?= 'Xfce4-power-manager'"
      "_GTK_FRAME_EXTENTS@:c"
      "_NET_WM_STATE@:32a *= '_NET_WM_STATE_HIDDEN'"
    ];
  };
}
