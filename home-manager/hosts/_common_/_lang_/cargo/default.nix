{ inputs, outputs, lib, config, pkgs, ... }:
let
	util = outputs.lib;
in {
	imports = util.fs.readSubmodules ./.;

	home.file.".cargo/config.toml".source = (pkgs.formats.toml {}).generate "cargo-config" {
		target.x86_64-unknown-linux-gnu = {
			linker = "clang";
			rustflags = ["-C" "link-arg=-fuse-ld=${lib.getExe pkgs.mold}"];
		};
	};
}
