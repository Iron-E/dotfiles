{
  lib,
  config,
  ...
}:
{
  imports = [ ];

  programs.starship.settings.env_var = {
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
}
