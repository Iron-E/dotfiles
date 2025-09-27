{ ... }:
{
  imports = [ ];

  programs.fish = {
    functions.fzf-cdg-widget = {
      description = "The FZF cd widget using Git's list of directories.";
      wraps = "";
      body = # fish
        ''
          set -l dirs (git ls-tree -rdt --name-only --full-tree HEAD) \
          || return $status

          set -lx fzf_opts \
            --no-multi \
            --reverse \
            --scheme=path \
            --height=40% \
            --walker-root=(git pwd) \
            --walker=dir,follow,hidden \
          || return $status

          set -l dir (string join \n -- $dirs/ | fzf $fzf_opts) \
          || return $status

          cd -- (git pwd)/$dir
        '';
    };

    functions.vi_bindings.body = # fish
      ''
        for mode in default insert
          bind -M $mode alt-g fzf-cdg-widget repaint
        end
      '';
  };
}
