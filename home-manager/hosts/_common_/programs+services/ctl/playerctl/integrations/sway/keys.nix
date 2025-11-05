{ config, lib, ... }:
{
  imports = [
    ../../../../../../_extras_/programs+services/gui/wayland/extras/window-manager/sway/lib
  ];

  wayland.windowManager.sway.config.keybindings =
    lib.optionalAttrs config.wayland.windowManager.sway.enable
      (
        let
          inherit (config.lib.iron-e.swayKey) lhs rhs;

          playerctl = lib.getExe config.services.playerctld.package;
          player =
            cmd: # string
            rhs.execInBg "${playerctl} ${cmd}";
        in
        {
          ### Media Control
          ${lhs.audio.next} = player "next";
          ${lhs.audio.pause} = player "pause";
          ${lhs.audio.play} = player "play";
          ${lhs.audio.prev} = player "previous";
        }
      );
}
