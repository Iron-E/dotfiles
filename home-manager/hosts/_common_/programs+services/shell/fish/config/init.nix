{ ... }:
{
  imports = [ ];

  programs.fish = {
    functions = {
      # used below, in the init phase
      vi_bindings = {
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
          '';
      };
    };

    interactiveShellInit = # fish
      ''
        set -g fish_greeting
        set -g fish_key_bindings vi_bindings # set keybindings
      '';
  };
}
