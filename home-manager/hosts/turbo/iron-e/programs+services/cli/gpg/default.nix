{ outputs, ... }:
let
  util = outputs.lib;
in
{
  imports = (util.fs.readSubmodules ./.) ++ [
    ../../../../../_common_/programs+services/cli/gpg/env.nix
    ../../../../../_common_/programs+services/cli/gpg/config
  ];

  programs.gpg.enable = true;
}
