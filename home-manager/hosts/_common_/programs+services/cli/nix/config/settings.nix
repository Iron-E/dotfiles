{ inputs, ... }:
{
  imports = [ ];

  nix = {
    gc = {
      automatic = true;
      frequency = "weekly";
    };

    nixPath = [ "nixpkgs=${inputs.nixpkgs}" ];

    settings = {
      auto-optimise-store = true;
      experimental-features = [
        "nix-command"
        "flakes"
      ];
    };
  };
}
