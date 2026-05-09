{ outputs, ... }:
let
  util = outputs.lib;
in
{
  imports = util.fs.readSubmodules ./.;

  programs.kubectl.kuberc.aliases = {
    rm.command = "delete";
    ctx.command = "config use-context";
    ns = {
      command = "config set-context";
      prependArgs = [
        "--current"
        "--namespace"
      ];
    };
  };
}
