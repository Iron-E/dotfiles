args@{ ... }:
{
  colors = import ./colors.nix args;
  keys = import ./keys.nix args;
  util = import ./util.nix args;
  workspaces = import ./workspaces.nix args;
}
