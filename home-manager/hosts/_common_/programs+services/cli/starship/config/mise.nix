{ ... }:
{
  imports = [ ];

  programs.starship.settings.mise = {
    disabled = false;
    format = "[]($style inverted)[ $symbol( $health)]($style fg:white)[ ]($style)";
    style = "bg:red_dark fg:black";
    healthy_symbol = "";
    symbol = "󰭼";
  };
}
