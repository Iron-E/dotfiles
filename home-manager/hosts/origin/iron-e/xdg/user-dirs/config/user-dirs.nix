{ config, ... }:
{
  imports = [ ];

  xdg.userDirs.extraConfig =
    let
      inherit (config.home) homeDirectory;
    in
    {
      XDG_PROG_DIR = "${homeDirectory}/Programming";
      XDG_REPO_DIR = "${homeDirectory}/Repos";
      XDG_VAULT_DIR = "${homeDirectory}/Vaults";
    };
}
