{
  config,
  outputs,
  lib,
  ...
}:
let
  util = outputs.lib;
in
{
  imports = [ ];

  wayland.windowManager.sway.config =
    let
      inherit (config.lib.iron-e.sway) key;

      workspaceCount = 10;
      workspaces = util.lists.reserveWith (i: toString (i + 1)) workspaceCount [
        "1 | Browsers"
        "2 | Misc"
        "3 | Editors"
        "4 | Background"
        "5 | Comms"
      ];

      workspace =
        idx: # integer
        builtins.elemAt workspaces (idx - 1);
    in
    {
      defaultWorkspace = workspace 1;
      workspaceAutoBackAndForth = true;

      assigns = {
        "\"${workspace 1}\"" = [
          { class = "Chromium"; }
          { class = "librewolf"; }
          { instance = "chromium"; }
          { instance = "Navigator"; }
        ];

        ### Word Processors
        "\"${workspace 3}\"" = [
          { instance = "libreoffice"; }
        ];

        ### Chat Applications
        "\"${workspace 5}\"" = [
          { class = "Signal"; }
        ];
      };

      keybindings =
        (lib.pipe workspaces [
          (lib.imap1 (
            idx: # integer
            workspaceName: # string
            let
              wrappedIdx = lib.mod idx workspaceCount;
              baseRhs = ''workspace "${workspaceName}"'';
            in
            [
              (lib.nameValuePair (key.lhsMod wrappedIdx) baseRhs)
              (lib.nameValuePair (key.lhsModShift wrappedIdx) "move container to ${baseRhs}")
            ]
          ))
          lib.flatten
          builtins.listToAttrs
        ])
        // {
          ${key.lhsMod key.greater} = "move workspace to output right";
          ${key.lhsMod key.less} = "move workspace to output left";
          ${key.lhsMod key.tab} = "workspace next";
          ${key.lhsModShift key.tab} = "workspace prev";
        };

      workspaceOutputAssign =
        let
          defaultOutputs = [
            "DisplayPort-3"
            "DisplayPort-2"
            "eDP"
          ];

          rhsMonitor = [
            "DisplayPort-6"
            "DisplayPort-4"
          ];

          output =
            workspace: # string
            outputs: # [string]
            {
              inherit workspace;
              output = outputs ++ defaultOutputs;
            };
        in
        [
          (output (workspace 1) rhsMonitor)
          (output (workspace 2) [ ])
          (output (workspace 3) [ ])
          (output (workspace 4) rhsMonitor)
          (output (workspace 5) rhsMonitor)
        ];
    };
}
