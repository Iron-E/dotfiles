{ inputs, outputs, lib, config, pkgs, ... }:
let
	util = outputs.lib;
in {
	imports = [];

	home.file.".cargo/config.toml".source = (pkgs.formats.toml {}).generate "cargo-config" {
		target.x86_64-unknown-linux-gnu = (lib.optionalAttrs (builtins.elem pkgs.mold config.home.packages) {
			linker = "clang";
			rustflags = ["-C" "link-arg=-fuse-ld=/usr/bin/mold"];
		});
	};
}
