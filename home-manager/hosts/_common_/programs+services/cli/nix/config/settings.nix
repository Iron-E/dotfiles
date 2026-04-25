{ inputs, ... }:
{
  imports = [ ];

  nix = {
    nixPath = [ "nixpkgs=${inputs.nixpkgs}" ];

    settings = {
      auto-optimise-store = false;
      experimental-features = [
        "nix-command"
        "flakes"
      ];
    };
  };
}
