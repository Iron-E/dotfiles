{ lib, ... }:
{
  imports = [ ];

  programs.git.extraConfig = lib.genAttrs [ "fetch" "receive" "transfer" ] (
    lib.const { fsckobjects = true; }
  );
}
