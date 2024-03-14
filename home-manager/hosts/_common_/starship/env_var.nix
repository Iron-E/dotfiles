{ config, outputs, ... }:
let
	util = outputs.lib;
in {
	imports = [];

	programs.starship.settings.env_var = {
		NNN = util.config.ifProgramEnabled "nnn" config {
			description = "Show whether the shell is being accessed inside NNN";
			format = "[]($style inverted)[ $env_value \${symbol} ]($style)";
			style = "bg:cyan fg:black";
			symbol = "n³";
			variable = "NNNLVL";
		};

		VIM = util.ifAnyProgramEnabled ["neovim" "vim"] config {
			description = "Show whether the shell is being accessed inside (Neo)Vim";
			format = "[]($style inverted)[ \${symbol} ]($style)";
			style = "bg:green fg:black";
			symbol = "";
			variable = "VIMRUNTIME";
		};
	};
}
