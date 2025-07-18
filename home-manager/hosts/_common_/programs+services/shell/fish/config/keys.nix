{ ... }:
{
  imports = [ ];

  programs.fish = {
    # used below, in the init phase
    functions.vi_bindings = {
      description = "vi keybindings with autosuggestion acceptance";
      body = # fish
        ''
          fish_vi_key_bindings

          bind -M insert alt-j down-or-search
          bind -M insert alt-k up-or-search
          for mode in default insert visual
            bind -M $mode ctrl-space forward-char
            bind -M $mode ctrl-f forward-word
          end

          if command -q watch || functions -q watch
            for mode in default insert
              bind -M $mode alt-w 'fish_commandline_prepend watch'
            end
          end

          if command -q bat || functions -q bat
            for mode in default insert
              bind -M $mode alt-b 'fish_commandline_append " | bat"'
            end
          end

          if command -q tspin || functions -q tspin
            for mode in default insert
              bind -M $mode alt-t 'fish_commandline_prepend "tspin -c \'fish -c \""' 'fish_commandline_append "\"\'"'
            end
          end
        '';
    };

    interactiveShellInit = # fish
      ''
        set -g fish_key_bindings vi_bindings # set keybindings
      '';
  };
}
