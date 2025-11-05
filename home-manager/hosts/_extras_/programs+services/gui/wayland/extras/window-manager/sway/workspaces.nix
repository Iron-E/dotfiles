{ config, lib, ... }:
{
  imports = [ ./lib ];

  wayland.windowManager.sway.config =
    let
      inherit (config.lib.iron-e.swayKey) lhs;
      wrksp = config.lib.iron-e.swayWorkspace;
    in
    {
      defaultWorkspace = wrksp.default;
      workspaceAutoBackAndForth = true;

      assigns = {
        "\"${wrksp.get 1}\"" = [
          { app_id = "librewolf"; }
          { app_id = "chromium"; }
        ];

        ### Word Processors
        "\"${wrksp.get 3}\"" = [
          { app_id = "libreoffice"; }
        ];

        ### Chat Applications
        "\"${wrksp.get 5}\"" = [
          { app_id = "signal"; }
        ];
      };

      keybindings =
        (lib.pipe wrksp.names [
          (lib.imap1 (
            idx: # integer
            workspaceName: # string
            let
              wrappedIdx = lib.mod idx wrksp.count;
              baseRhs = ''workspace "${workspaceName}"'';
            in
            [
              (lib.nameValuePair (lhs.withMod wrappedIdx) baseRhs)
              (lib.nameValuePair (lhs.withModShift wrappedIdx) "move container to ${baseRhs}")
            ]
          ))
          lib.flatten
          builtins.listToAttrs
        ])
        // {
          ${lhs.withMod lhs.greater} = "move workspace to output right";
          ${lhs.withMod lhs.less} = "move workspace to output left";
          ${lhs.withMod lhs.tab} = "workspace next";
          ${lhs.withModShift lhs.tab} = "workspace prev";
        };
    };
}
