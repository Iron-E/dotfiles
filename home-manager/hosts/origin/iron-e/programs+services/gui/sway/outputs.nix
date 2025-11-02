{ config, pkgs, ... }:
{
  imports = [ ../../../../../_extras_/programs+services/gui/wayland/extras/window-manager/sway/lib ];

  home.packages = with pkgs; [ swaybg ];
  wayland.windowManager.sway.config =
    let
      laptop = "AU Optronics 0x403D Unknown";
      leftMonitor = "LG Electronics LG HDR 4K 0x0004DF17";
      rightMonitor = "Dell Inc. DELL U2725QE 2B11H84";
    in
    {
      bindswitches = {
        "lid:on" = {
          reload = true;
          locked = true;
          action = ''output "${laptop}" disable'';
        };

        "lid:off" = {
          reload = true;
          locked = true;
          action = ''output "${laptop}" enable'';
        };
      };

      output = {
        ${leftMonitor} = {
          mode = "2560x1440@59.951Hz";
          transform = "270";
          position = "0 0";
        };

        ${rightMonitor} = {
          mode = "2560x1440@59.951Hz";
          position = "1440 572";
        };

        ${laptop} = {
          mode = "1920x1080@60.049Hz";
          position = "4000 572";
        };
      };

      workspaceOutputAssign =
        let
          wrksp = config.lib.iron-e.swayWorkspace;
        in
        [
          (wrksp.assignOutput (wrksp.get 1) [ leftMonitor ])
          (wrksp.assignOutput (wrksp.get 2) [ rightMonitor ])
          (wrksp.assignOutput (wrksp.get 3) [ rightMonitor ])
          (wrksp.assignOutput (wrksp.get 4) [ leftMonitor ])
          (wrksp.assignOutput (wrksp.get 5) [ leftMonitor ])
        ];
    };
}
