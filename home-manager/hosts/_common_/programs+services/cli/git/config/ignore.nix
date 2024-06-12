{ inputs, outputs, lib, config, pkgs, ... }:
let
	util = outputs.lib;
in {
	imports = [];

	programs.git.ignores = [
		/* gitignore */ "**/*.bak"
		/* gitignore */ "**/*.log"
		/* gitignore */ "**/*.orig"
		/* gitignore */ "**/*.pyc"
		/* gitignore */ "**/*.swp"
		/* gitignore */ "**/*.temp"
		/* gitignore */ "**/*.tmp"
		/* gitignore */ "**/*~"
		/* gitignore */ "**/.env"
		/* gitignore */ "**/.envrc"
		/* gitignore */ "**/node_modules/"
	];
}
