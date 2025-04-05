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
              bind -M $mode -k nul forward-char
              bind -M $mode ctrl-f forward-word
            end

            if command -qs watch
              for mode in default insert
                bind -M $mode alt-w 'fish_commandline_prepend watch'
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
