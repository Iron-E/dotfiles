{ ... }:
{
  imports = [ ];

  programs.nushell.extraConfig = # nu
    ''
      use themes/highlite.nu;
      $env.config.color_config = (highlite);
    '';
}
