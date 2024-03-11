nixpkgs: # `flake`
let
	inherit (nixpkgs) lib;
	default = ["aarch64-darwin" "aarch64-linux" "i686-linux" "x86_64-darwin" "x86_64-linux"];
in {
	default = default;
	genValues = lib.genAttrs default;
}
