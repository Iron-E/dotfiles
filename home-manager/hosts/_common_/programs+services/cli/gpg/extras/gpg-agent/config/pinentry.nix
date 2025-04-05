{ lib, config, ... }:
{
  imports = [ ];

  services.gpg-agent.pinentryPackage = config.lib.pinentry.package;
}
