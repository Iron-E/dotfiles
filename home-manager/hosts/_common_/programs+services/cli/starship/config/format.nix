{
  lib,
  config,
  outputs,
  ...
}:
let
  util = outputs.lib;
in
{
  imports = [ ];

  programs.starship.settings.format = util.strings.join [
    [ "([░▒▓\${directory}](purple_light))" ]

    (lib.optionals config.programs.git.enable [
      "("
      "[ ](fg:black bg:green_dark)"
      "\${git_branch}"
      "\${git_commit}"
      "\${git_state}"
      "[](fg:green_dark)"
      ")"
      "\${git_status}"
    ])

    [
      "\${fill}"
      "\${status}"
      "\${cmd_duration}"
      "\${jobs}"
      "\${mise}"
      "\${direnv}"
      "\${nix_shell}"
      "\${env_var.NNN}"
      "\${env_var.NVIM}"
      "\${env_var.VIM}"
      "\${env_var.YAZI}"
      "\${aws}"
      "\${time}"
      "\n"
      "\${character}"
    ]
  ];
}
