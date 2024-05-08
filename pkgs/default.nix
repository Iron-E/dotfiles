# Custom packages, that can be defined similarly to ones from nixpkgs
# You can build them using 'nix build .#example'
pkgs:
let inherit (pkgs) callPackage;
in {
	rpm-spec-language-server = callPackage ./python3/rpm-spec-language-server/bin.nix { };
	rpm-spec-language-server-fhs = callPackage ./python3/rpm-spec-language-server { };
	specfile = callPackage ./python3/specfile { };
}
