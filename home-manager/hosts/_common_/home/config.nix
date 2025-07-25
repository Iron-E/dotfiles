{ pkgs, config, ... }:
{
  imports = [ ];

  home = {
    enableNixpkgsReleaseCheck = true;
    homeDirectory = "/${if pkgs.stdenv.isDarwin then "Users" else "home"}/${config.home.username}";
    language.base = "en_US.UTF-8";
    preferXdgDirectories = true;
  };
}
