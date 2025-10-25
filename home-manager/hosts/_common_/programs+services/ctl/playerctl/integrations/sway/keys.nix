{ config, lib, ... }:
{
  imports = [ ];

  wayland.windowManager.sway.config.keybindings =
    lib.optionalAttrs config.wayland.windowManager.sway.enable
      (
        let
          inherit (config.lib.iron-e.sway.key) lhs rhs;

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
