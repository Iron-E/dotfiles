{ config, lib, ... }:
{
  imports = [ ];

  programs.nushell.shellAliases = lib.mkOverride 60 {
    "a" = "append";
    "cat" = "open --raw";
    "clr" = "clear";
    "cut" = "select";
    "from jsonl" = "from json -o";
    "head" = "first";
    "ins" = "insert";
    "la" = "ls -a";
    "less" = "explore";
    "o" = "open";
    "p" = "prepend";
    "tail" = "last";
    "type" = "describe";
    "up" = "update";
    "ups" = "upsert";
    "w" = "where";
  };
}
