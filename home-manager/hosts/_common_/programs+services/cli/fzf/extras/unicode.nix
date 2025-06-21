{ pkgs, ... }:
{
  imports = [ ];

  home.packages = [
    (pkgs.writeShellApplication {
      name = "fzu";
      text = # sh
        ''
          fzf \
            --delimiter '\t' \
            --nth=2 \
            --accept-nth=1 \
            < ${./unicode.txt}
        '';
    })
  ];
}
