{ config, lib, ... }:
{
  imports = [ ];

  programs.fish = lib.optionalAttrs config.programs.zellij.enable {
    functions = {
      zc = {
        description = "Run a command in a floating zellij window and write its stdout";
        body = # fish
          ''
            # setup
            set -f dir (mktemp -d)
            set -f pipe $dir/fzf.pipe
            mkfifo $pipe

            # script
            zellij run \
            	--floating \
              --pinned=true \
            	--close-on-exit \
              --name $argv[1] \
            	-- \
            	fish \
            	--command \
            	"$argv > $pipe"

            cat $pipe

            # cleanup
            rm -rf $dir
          '';
      };

      zcw = {
        description = "Run a command in a floating zellij window and write the stdout to the current pane";
        wraps = "zc";
        body = # fish
          ''
            set -f output (zc $argv)
            if [ -n $output ]
              zellij action write-chars (zc $argv)
            end
          '';
      };
    };

    interactiveShellInit = # fish
      ''
        zellij setup --generate-completion fish | source
      '';
  };
}
