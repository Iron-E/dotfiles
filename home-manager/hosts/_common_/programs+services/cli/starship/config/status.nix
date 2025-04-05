{ ... }:
{
  imports = [ ];

  # this can be massively simplified after starship/starship#4945
  programs.starship.settings.status = {
    disabled = false;
    format = "$symbol";
    map_symbol = true;
    not_executable_symbol = "[](bg:black fg:magenta_dark)[ 󰂭 $common_meaning ](fg:black bg:magenta_dark)";
    not_found_symbol = "[](bg:black fg:magenta)[  $common_meaning ](fg:black bg:magenta)";
    recognize_signal_code = true;
    sigint_symbol = "[](bg:black fg:pink_light)[ 󱠰 ](fg:black bg:pink_light)";
    signal_symbol = "[](bg:black fg:yellow)[  $common_meaning $signal_name ](fg:black bg:yellow)";
    symbol = "[](bg:black fg:red)[  ($common_meaning )($signal_name )$status ](fg:black bg:red)";
  };
}
