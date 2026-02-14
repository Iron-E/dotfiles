{ config, ... }:
{
  imports = [ ];

  xdg.userDirs.extraConfig =
    let
      inherit (config.home) homeDirectory;
    in
    {
      PROG = "${homeDirectory}/Programming";
      REPO = "${homeDirectory}/Repos";
      VAULT = "${homeDirectory}/Vaults";
    };
}
