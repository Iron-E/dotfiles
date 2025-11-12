{ inputs, ... }:
{
  imports = [ ];

  targets.genericLinux = {
    enable = true;
    nixGL.packages = inputs.nixgl.packages;
  };
}
