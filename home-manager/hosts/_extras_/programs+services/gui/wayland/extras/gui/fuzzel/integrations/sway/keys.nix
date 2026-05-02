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
          fish = lib.getExe config.programs.fish.package;
          fuzzel = lib.getExe config.programs.fuzzel.package;
        in
        {
          ${lhs.withMod lhs.space} = rhs.exec fuzzel;
          ${lhs.withMod "x"} = rhs.exec "${fish} -c run_fuzzel_command";
        }
      );

  programs.fish.functions.run_fuzzel_command =
    lib.optionalAttrs config.wayland.windowManager.sway.enable
      (
        let
          inherit (config.wayland.windowManager.sway.config) terminal;
          fd = lib.getExe pkgs.fd;
          fuzzel = lib.getExe config.programs.fuzzel.package;
        in
        {
          description = "Run a command selected by a fuzzel prompt.";
          body = # fish
            ''
              ${fd} -t x -L . $PATH -x echo {/} 2>/dev/null | sort -iu | ${fuzzel} --dmenu | read -ta cmd
              ${terminal} -e $cmd
            '';
        }
      );
}
