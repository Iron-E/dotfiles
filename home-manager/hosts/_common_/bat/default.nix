{ outputs, ... }: {
	imports = outputs.lib.fs.readSubmodules ./.;

	programs.bat = {
		enable = true;
		config = {
			italic-text = "always";
			pager = "less -R";
			style = "full";
		};
	};
}
