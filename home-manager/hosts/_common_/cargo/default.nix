{ ... }: {
	imports = [];

	home.file.".cargo/config.toml".source = ./config.toml;
}
