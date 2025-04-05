# Custom packages, that can be defined similarly to ones from nixpkgs
# You can build them using 'nix build .#example'
pkgs:
let
  inherit (pkgs) callPackage;
in
{
  # rift = callPackage ./bash/rift.nix { };
}
