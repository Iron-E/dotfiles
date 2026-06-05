{ outputs, ... }:
let
  util = outputs.lib;
in
{
  imports = util.fs.readSubmodules ./.;

  programs.ssh =
    let
      IdentityAgent = ''"~/PATH/GOES/HERE"'';
    in
    {
      enableDefaultConfig = false;

      matchBlocks = {
        "*" = {
          controlMaster = "auto";
          controlPath = "~/.ssh/cm-%r@%h:%p";
          controlPersist = "30s";
          setEnv.TERM = "xterm-256color"; # HACK: ghostty not working right on older machines via ssh
          user = "iron-e";

          extraOptions = {
            inherit IdentityAgent;
          };
        };

        "*.gitlab.com" = {
          extraOptions = { inherit IdentityAgent; };
          user = "iron-e";
        };
      };
    };
}
