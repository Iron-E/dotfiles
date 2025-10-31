{ pkgs, ... }:
{
  home.packages = with pkgs; [ swaybg ];
  wayland.windowManager.sway.config =
    let
      laptop = "AU Optronics 0x403D Unknown";
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
        "LG Electronics LG HDR 4K 0x0004DF17" = {
          mode = "2560x1440@59.951Hz";
          transform = "270";
          pos = "0 0";
        };

        "Dell Inc. DELL U2725QE 2B11H84" = {
          mode = "2560x1440@59.951Hz";
          pos = "1440 572";
        };

        ${laptop} = {
          mode = "1920x1080@60.049Hz";
          pos = "4000 572";
        };
      };
    };
}
