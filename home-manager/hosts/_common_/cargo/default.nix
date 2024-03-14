{ config, lib, pkgs, outputs, ... }: {
	imports = [];

	home.file.".cargo/config.toml".text = outputs.lib.strings.joinLines [
		[ /* toml */ "[target.x86_64-unknown-linux-gnu]" ]

		(lib.optional (builtins.elem pkgs.mold config.home.packages) [
			/* toml */ "linker = 'clang'"
			/* toml */ "rustflags = ['-C', 'link-arg=-fuse-ld=/usr/bin/mold']"
		])
	];
}
