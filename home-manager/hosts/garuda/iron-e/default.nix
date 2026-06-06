{ outputs, ... }:
let
  util = outputs.lib;
in
{
  imports =
    (util.fs.readSubmodules ./.)
    ++ [
      ../../_extras_/programs+services/cli/_1password
      ../../_extras_/programs+services/cli/aws
      ../../_extras_/programs+services/ctl/colima
      ../../_extras_/programs+services/ctl/kubectl
    ]
    ++ (util.fs.filterSubmodules ../../_common_ [
      ../../_common_/programs+services
    ])
    ++ (util.fs.filterSubmodules ../../_common_/programs+services [
      ../../_common_/programs+services/ctl
      ../../_common_/programs+services/lang
    ])
    ++ [
      ../../_common_/programs+services/ctl/docker
    ];

  home =
    let
      username = "iron-e";
    in
    {
      inherit username;

      # SEE: https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
      stateVersion = "26.05";

      sessionVariables.HM_PROFILE = "${username}@garuda";
    };

  xdg.enable = true;
}
