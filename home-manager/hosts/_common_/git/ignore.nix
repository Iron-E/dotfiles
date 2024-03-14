{ ... }: {
	imports = [];

	programs.git.ignores = [
		/* gitignore */ "*.bak"
		/* gitignore */ "*.log"
		/* gitignore */ "*.pyc"
		/* gitignore */ "*.swp"
		/* gitignore */ "*.temp"
		/* gitignore */ "*.tmp"
		/* gitignore */ "*~"
		/* gitignore */ "node_modules/"
	];
}
