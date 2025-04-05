{ pkgs, lib, ... }:
{
  imports = [ ];

  home.packages = lib.toList (
    let
      name = "rift";
    in
    pkgs.writeShellApplication {
      inherit name;

      runtimeInputs = with pkgs; [ redshift ];
      text = # sh
        ''
          case "''${1-}" in
            "blue")
              TEMPERATURE=5500
              ;;
            "yellow")
              TEMPERATURE=3750
              ;;
            "orange")
              TEMPERATURE=2000
              ;;
            "red")
              TEMPERATURE=1300
              ;;
            ""|"-h")
              cat << EOF
          Conveniently overwite the current redshift settings.

          Usage: rift (blue|yellow|orange|red|INT) [OPACITY]

          Arguments:
            blue       set the screen temperature to 5500
            yellow     set the screen temperature to 3750
            orange     set the screen temperature to 2000
            red        set the screen temperature to 1300
            INT        an integer value representing the desired screen temperature
            [OPACITY]  a number in the range 0..=1.0 which represents the desired screen opacity / brightness
          EOF
              exit 0
              ;;
            *)
              TEMPERATURE="$1"
              ;;
          esac

          redshift -PO "''$TEMPERATURE" -b "''${2:-1.0}"
        '';
    }
  );
}
