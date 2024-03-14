{ ... }: {
	imports = [];

	home.file.".cargo/config.toml".text = /* toml */ ''
		[target.x86_64-unknown-linux-gnu]
		linker = "clang"
		rustflags = ["-C", "link-arg=-fuse-ld=/usr/bin/mold"]
	'';
}
