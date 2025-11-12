{ lib, ... }:
{
  imports = [ ];

  programs.git.settings = lib.genAttrs [ "fetch" "receive" "transfer" ] (
    lib.const { fsckobjects = true; }
  );
}
