args@{ outputs, lib, ... }:
let
  util = outputs.lib;
  settings = map (p: import p args) (util.fs.readSubmodules ./.);
in
lib.foldl' lib.recursiveUpdate { } settings
