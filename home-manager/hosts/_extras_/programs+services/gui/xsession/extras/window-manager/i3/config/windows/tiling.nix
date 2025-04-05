args@{
  lib,
  outputs,
  config,
  ...
}:
let
  inherit (import ../lib/keys.nix args)
    genDirectionMaps
    getVimDirection
    lhsMod
    lhsModShift
    ;
  inherit (lib) id;

  util = outputs.lib;
in
{
  imports = [ ];

  xsession.windowManager.i3 = {
    config = {
      keybindings =
        let
          genMaps = genDirectionMaps lib.toLower;

          genFocusMaps = genMaps lhsMod (v: "focus ${v}");
          genMoveMaps = genMaps lhsModShift (v: "move ${v}");
        in
        util.attrsets.concat [
          (genFocusMaps id)
          (genFocusMaps getVimDirection)
          (genMoveMaps id)
          (genMoveMaps getVimDirection)

          {
            ${lhsMod "c"} = "focus child"; # focus the child container
            ${lhsMod "f"} = "fullscreen toggle"; # enter fullscreen mode for the focused container
            ${lhsMod "p"} = "focus parent"; # focus the parent container
            ${lhsMod "v"} = "split h"; # split down the vertical axis
            ${lhsModShift "s"} = "split v"; # split down the horizontal axis

            # change container layout (stacked, tabbed, toggle split)
            ${lhsMod "s"} = "layout toggle split";
            ${lhsMod "t"} = "layout tabbed";
            ${lhsMod "w"} = "layout stacking";

          }
        ];

      window.border = 1;
    };

    extraConfig = # i3config
      ''
        default_border pixel ${builtins.toString config.xsession.windowManager.i3.config.window.border}
      '';
  };
}
