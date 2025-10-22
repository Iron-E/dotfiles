# This is your home-manager configuration file
# Use this to configure your home environment (it replaces ~/.config/nixpkgs/home.nix)
{ outputs, ... }:
let
  util = outputs.lib;
in
{
  imports = (util.fs.readSubmodules ./.) ++ [
    ../../_common_
    ../../_extras_/programs+services/cli/aws
    ../../_extras_/programs+services/cli/cryfs
    ../../_extras_/programs+services/cli/nextdns
    ../../_extras_/programs+services/ctl/autorandr
    ../../_extras_/programs+services/ctl/kubectl
    ../../_extras_/programs+services/gui/bitwarden
    ../../_extras_/programs+services/gui/wayland
    ../../_extras_/programs+services/gui/xsession
  ];

  home = {
    username = "iron-e";

    # SEE: https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
    stateVersion = "24.05";
  };
}
