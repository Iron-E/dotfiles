{ lib, config, ... }:
{
  imports = [ ];

  programs.delta.options = {
    navigate = true;
    line-numbers = true;
    syntax-theme = # try to get the bat theme, falling back to `DarkNeon`
      lib.attrByPath [ "programs" "bat" "config" "theme" ] "DarkNeon" config;
  };
}
