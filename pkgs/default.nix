# Custom packages, that can be defined similarly to ones from nixpkgs
# You can build them using 'nix build .#example'
pkgs:
let
  inherit (pkgs) callPackage;
in
{
  git-worktree-share = callPackage ./git-worktree-share.nix { };
  ctrld = callPackage ./ctrld.nix { };
  leaf = callPackage ./leaf.nix { };
  lombok = callPackage ./lombok.nix { };
}
