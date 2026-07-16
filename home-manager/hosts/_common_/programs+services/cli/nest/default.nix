{ outputs, pkgs, ... }:
let
  util = outputs.lib;
in
{
  imports = util.fs.readSubmodules ./.;

  home.packages = [
    (pkgs.writeShellApplication {
      name = "nest";
      text = # sh
        ''
          PARENT="''${1:?must pass <parent> dir}"
          CHILD="''${2:?must pass <child> dir}"

          CHILD_DIR="$(dirname "$CHILD")"
          CHILD_BASE="$(basename "$CHILD")"

          if [ ! -e "$PARENT" ]; then
            echo "<parent> does not exist on disk"
            exit 1
          fi

          if ! command -v mktemp &>/dev/null; then
            echo "mktemp not found"
            exit 1
          fi

          DIR="$(mktemp -d)"

          set -x
          mv "$PARENT" "$DIR"
          mkdir -p "$PARENT/$CHILD_DIR"
          mv "$DIR/$PARENT" "$PARENT/$CHILD_DIR/$CHILD_BASE"
        '';
    })
  ];
}
