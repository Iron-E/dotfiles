{
  lib,
  config,
  ...
}:
{
  imports = [ ];

  programs = {
    starship.settings.env_var = {
      NNN = lib.optionalAttrs config.programs.nnn.enable {
        description = "Show whether the shell is being accessed inside NNN";
        format = "[]($style inverted)[ $env_value \${symbol} ]($style)";
        style = "bg:cyan fg:black";
        symbol = "n³";
        variable = "NNNLVL";
      };

      NVIM = {
        description = "Show whether the shell is being accessed inside NeoVim";
        format = "[]($style inverted)[ \${symbol} ]($style)";
        style = "bg:green fg:black";
        symbol = " ";
        variable = "NVIM";
      };

      SHELL_PRIVATE = {
        description = "Show whether fish shell history is disabled";
        format = "[]($style inverted)[ \${symbol}]($style)";
        style = "bg:white fg:black";
        symbol = "󰗹 ";
        variable = "STARSHIP_SHELL_PRIVATE";
      };

      VIM = {
        description = "Show whether the shell is being accessed inside Vim";
        format = "[]($style inverted)[ \${symbol} ]($style)";
        style = "bg:green fg:black";
        symbol = " ";
        variable = "VIMRUNTIME";
      };

      YAZI = {
        description = "Show whether the shell is being accessed inside (Neo)Vim";
        format = "[]($style inverted)[ \${symbol} ]($style)";
        style = "bg:yellow fg:black";
        symbol = " ";
        variable = "YAZI_LEVEL";
      };
    };

    fish = {
      interactiveShellInit = # fish
        ''
          __starship_is_private_hook
        '';

      functions.__starship_is_private_hook = {
        description = "Expose whether fish is in private mode.";
        onVariable = "fish_private_mode";
        body = # fish
          ''
            if set -q fish_private_mode
              set -gx STARSHIP_SHELL_PRIVATE $fish_private_mode
            else
              set -eg STARSHIP_SHELL_PRIVATE $fish_private_mode
            end
          '';
      };
    };
  };
}
