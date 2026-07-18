{ lib, outputs, ... }:
let
  util = outputs.lib;
in
{
  imports = util.fs.readSubmodules ./.;

  programs.fish.functions =
    let
      mkbody =
        op: # string
        letter: # string
        adjust: # int as string
        # fish
        ''
          argparse (fish_opt -s h -l help) -- $argv

          if [ -n "$_flag_help" ] || [ -z "$argv[1]" ]
            echo  "
            Usage: $0 [OPTIONS] <[-]times>

            Options:
              -h, --help  Print help
            "
            return
          end

          set -f adjust ${lib.strings.escapeShellArg adjust}
          set -f range $argv[1]
          if [ (string sub -l 1 -- $argv[1]) = "-" ]
            set -f adjust -$adjust
            set -f range (string sub -s 2 -- $argv[1])
          end

          for i in (seq $range)
            busctl --user -- call rs.wl-gammarelay / rs.wl.gammarelay ${
              lib.strings.escapeShellArgs [
                op
                letter
              ]
            } $adjust;
          end
        '';

    in
    {
      gamma-bright = {
        description = "Update screen brightness.";
        body = mkbody "UpdateBrightness" "d" "0.1";
      };

      gamma-temp = {
        description = "Update screen temperature.";
        body = mkbody "UpdateTemperature" "n" "250";
      };

      gamma-cont = {
        description = "Update screen contrast.";
        body = mkbody "UpdateGamma" "d" "0.1";
      };
    };
}
