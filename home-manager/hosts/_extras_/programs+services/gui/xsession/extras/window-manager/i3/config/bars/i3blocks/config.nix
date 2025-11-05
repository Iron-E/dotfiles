{ inputs, lib, ... }:
let
  # i3blocks constants
  none = "none";
  once = "once";
  pango = "pango";
in
{
  imports = [ ];

  xdg.configFile."i3blocks/top.conf".text = lib.mkBefore (
    # The properties below are applied to every block, but can be overridden.
    # Each block command defaults to the script name to avoid boilerplate.
    lib.generators.toINIWithGlobalSection { } {
      globalSection = {
        command = "${inputs.i3blocks-contrib}/$BLOCK_NAME/$BLOCK_NAME";
        markup = none;
        separator_block_width = 15;
      };
    }
  );

  # ("# vim" + ": ft=dosini")

  programs.i3blocks.bars."top.conf" =
    let
      inherit (lib.hm) dag;

      # an icon for a `section` with `name`
      icon =
        unicode: # string
        {
          command = # sh
            "echo -e '\\u${unicode} '";
          interval = once;
          markup = pango;
          separator = false;
          separator_block_width = 5;
        };
    in
    {
      volume_icon = icon "f0f3";
      volume = dag.entryAfter [ "volume_icon" ] {
        instance = "Master";
        interval = once;
        signal = 10;
      };

      disk_icon = dag.entryAfter [ "volume" ] (icon "f07c");
      disk = dag.entryAfter [ "disk_icon" ] {
        interval = 240;
      };

      temperature_icon = dag.entryAfter [ "disk" ] (icon "f2c9");
      temperature = dag.entryAfter [ "temperature_icon" ] {
        color = "#01b9ff";
        interval = 30;
      };

      battery2 = dag.entryAfter [ "temperature" ] {
        interval = 30;
        markup = pango;
      };

      date = dag.entryAfter [ "battery2" ] {
        command = # sh
          "date '+%Y/%m/%d'";
        interval = 3600;
        separator = false;
        separator_block_width = 10;
      };

      time = dag.entryAfter [ "date" ] {
        command = # sh
          "date '+%H:%M:%S EST'";
        interval = 30;
      };

      separator = dag.entryAfter [ "time" ] {
        full_text = "";
        interval = once;
        separator = true;
        separator_block_width = 10;
      };

      wifi = dag.entryAfter [ "separator" ] {
        command = # sh
          "nm-applet";
        interval = once;
      };
    };
}
