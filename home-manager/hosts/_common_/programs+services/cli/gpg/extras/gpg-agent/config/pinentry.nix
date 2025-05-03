{ lib, config, ... }:
{
  imports = [ ];

  services.gpg-agent.pinentry = config.lib.pinentry;
}
