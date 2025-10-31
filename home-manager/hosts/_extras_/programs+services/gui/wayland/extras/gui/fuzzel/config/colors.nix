{ ... }:
{
  imports = [ ];

  programs.fuzzel.settings.colors = rec {
    background = "353535ff";
    text = "c0c0c0ff";
    prompt = "f0af00ff";
    placeholder = "808080ff";
    input = text;
    match = "2bff99ff";
    selection = "264f60ff";
    selection-text = text;
    selection-match = match;
    counter = "ffb7b7ff";
    border = "ffffffff";
  };
}
