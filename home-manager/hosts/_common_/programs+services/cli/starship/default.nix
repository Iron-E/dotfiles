{ outputs, ... }:
{
  imports = outputs.lib.fs.readSubmodules ./.;

  programs.starship.enable = true;
  programs.starship.settings."$schema" = "https://starship.rs/config-schema.json";
}
