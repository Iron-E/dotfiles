{ config, ... }:
{
  imports = [ ];

  home.sessionVariables =
    let
      awsConfigDir = "${config.xdg.configHome}/aws";
    in
    {
      AWS_CONFIG_FILE = "${awsConfigDir}/config";
      AWS_SHARED_CREDENTIALS_FILE = "${awsConfigDir}/credentials";
    };
}
