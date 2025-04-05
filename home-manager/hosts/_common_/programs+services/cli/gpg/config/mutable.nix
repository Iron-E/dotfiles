{ ... }:
{
  imports = [ ];

  programs.gpg = {
    mutableKeys = true;
    mutableTrust = true;
  };
}
