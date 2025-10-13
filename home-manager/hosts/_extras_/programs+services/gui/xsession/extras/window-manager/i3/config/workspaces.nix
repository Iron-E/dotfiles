args@{
  lib,
  outputs,
  ...
}:
let
  inherit (builtins)
    concatStringsSep
    genList
    length
    listToAttrs
    toString
    ;
  inherit (lib)
    id
    nameValuePair
    pipe
    toList
    ;

  i3Lib = import ./lib args;
  inherit (i3Lib.keys)
    greater
    less
    lhsMod
    lhsModShift
    tab
    ;
  inherit (i3Lib.util) i3Exe;
  inherit (i3Lib.workspaces) workspace workspaces;

  util = outputs.lib;
  inherit (util.attrsets) pair;

  defaultWorkspace = workspace 3;
in
{
  imports = [ ];

  xsession.windowManager.i3.config = {
    inherit defaultWorkspace;
    startup = toList (pair "command" "${i3Exe "i3-msg"} 'workspace ${defaultWorkspace}'");
    workspaceAutoBackAndForth = true;

    assigns = {
      ${workspace 1} = [
        { class = "Chromium"; }
        { class = "librewolf"; }
        { instance = "chromium"; }
        { instance = "Navigator"; }
      ];

      ### Word Processors
      ${workspace 3} = [
        { instance = "libreoffice"; }
      ];

      ### Chat Applications
      ${workspace 5} = [
        { class = "Signal"; }
      ];
    };

    keybindings =
      let
        genWorkspaceMaps =
          lhsFn: rhsFn:
          pipe workspaces [
            length # ["1 | Foo" "2 | Bar" ...] -> 10
            (genList (
              i:
              let
                pipe' = pipe i;
              in
              nameValuePair
                (pipe' [
                  toString
                  lhsFn
                ])
                (pipe' [
                  workspace
                  (v: "workspace ${toString v}")
                  rhsFn
                ])
            )) # -> [{name = lhs; value = rhs;} ...]

            listToAttrs # -> { lhs = rhs; lhs2 = rhs2; ... }
          ];
      in
      util.attrsets.concat [
        (genWorkspaceMaps lhsMod id)
        (genWorkspaceMaps lhsModShift (v: "move container to ${v}"))

        ## Move focused workspace to another monitor
        {
          ${lhsMod greater} = "move workspace to output right";
          ${lhsMod less} = "move workspace to output left";
          ${lhsMod tab} = "workspace next";
          ${lhsModShift tab} = "workspace prev";
        }
      ];

    workspaceOutputAssign =
      let
        laptop = [ "eDP" ];

        lhsMonitor = [
          "DisplayPort-3"
          "DisplayPort-2"
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
            output = concatStringsSep " " (outputs ++ lhsMonitor ++ laptop);
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
