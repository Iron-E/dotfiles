{ ... }:
{
  imports = [ ];

  # this can be massively simplified after starship/starship#4945
  programs.starship.settings.aws = {
    disabled = false;
    format = "[]($style inverted)[( $profile)( \\$duration\\) $symbol ]($style)";
    style = "bg:cyan fg:black";
    symbol = " ";
    expiration_symbol = "󱦟";
  };
}
