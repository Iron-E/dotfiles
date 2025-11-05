{ config, ... }:
{
  imports = [ ];

  systemd.user.sessionVariables = builtins.removeAttrs config.home.sessionVariables [ "NIX_PATH" ];
}
