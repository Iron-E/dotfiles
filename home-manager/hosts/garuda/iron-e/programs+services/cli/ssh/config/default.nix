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

      settings = {
        "*" = {
          ControlMaster = "auto";
          ControlPath = "~/.ssh/cm-%r@%h:%p";
          ControlPersist = "30s";
          SetEnv.TERM = "xterm-256color"; # HACK: ghostty not working right on older machines via ssh

          inherit IdentityAgent;
        };

        "*.github.com" = {
          User = builtins.getEnv "GIT_USER_NAME";
        };
      };
    };
}
