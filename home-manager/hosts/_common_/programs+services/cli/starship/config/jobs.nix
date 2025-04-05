{ lib, ... }:
{
  imports = [ ];

  programs.starship.settings.jobs = {
    format = lib.concatStrings [
      "[](bg:black fg:gray_darker)"
      "[ $number$symbol ]($style)"
      "[]($style fg:black)"
    ];

    style = "bg:gray_darker fg:blue";
  };
}
