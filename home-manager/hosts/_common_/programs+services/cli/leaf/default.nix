{ outputs, ... }:
{
  imports = outputs.lib.fs.readSubmodules ./.;

  # TODO: package leaf
}
