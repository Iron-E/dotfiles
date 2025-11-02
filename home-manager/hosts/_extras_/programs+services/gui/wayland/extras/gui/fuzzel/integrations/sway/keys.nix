{
  config,
  lib,
  pkgs,
  ...
}:
{
  imports = [ ../../../../window-manager/sway/lib ];

  wayland.windowManager.sway.config.keybindings =
    lib.optionalAttrs config.wayland.windowManager.sway.enable
      (
        let
          inherit (config.lib.iron-e.swayKey) lhs rhs;
          inherit (config.wayland.windowManager.sway.config) terminal;
          fd = lib.getExe pkgs.fd;
          fish = lib.getExe config.programs.fish.package;
          fuzzel = lib.getExe config.programs.fuzzel.package;
        in
        {
          ${lhs.withMod lhs.space} = rhs.exec fuzzel;
          ${lhs.withMod "x"} =
            let
              command = "${terminal} -e (${fd} -t x -L  . $PATH -x echo {/} 2>/dev/null | sort -iu | ${fuzzel} --dmenu | string escape || exit $status)";
            in
            rhs.exec "${fish} -c ${lib.escapeShellArg command}";
        }
      );
}
