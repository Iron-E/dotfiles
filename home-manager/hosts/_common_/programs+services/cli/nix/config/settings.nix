{ pkgs, inputs, ... }:
{
  imports = [ ];

  nix = {
    nixPath = [ "nixpkgs=${inputs.nixpkgs}" ];

    settings = {
      auto-optimise-store = !pkgs.stdenv.isDarwin;
      experimental-features = [
        "nix-command"
        "flakes"
      ];
    };
  };
}
