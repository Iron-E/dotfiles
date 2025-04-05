{ lib, ... }:
{
  imports = [ ];

  programs.starship.settings.directory = {
    format = "[ $path ($read_only )]($style)";
    style = "bg:purple_light fg:white";
    read_only_style = "bg:purple_light fg:white";
    truncate_to_repo = false;
    truncation_length = 8;
    truncation_symbol = "…/";
    repo_root_style = "bg:purple_light fg:white bold italic";
    repo_root_format = lib.concatStrings [
      "[ $before_root_path]($style)"
      "[$repo_root]($repo_root_style)"
      "[$path ($read_only )]($style)"
    ];
  };
}
