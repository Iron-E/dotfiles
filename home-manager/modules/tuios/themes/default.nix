{ outputs, ... }:
let
  util = outputs.lib;
in
util.fs.genSubmoduleAttrs ./. (module: import module)
