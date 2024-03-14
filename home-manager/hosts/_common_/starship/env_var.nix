{ config, lib, outputs, ... }: {
	imports = [];

	programs.starship.settings.env_var = {
		NNN = lib.optionalAttrs (outputs.lib.config.isProgramEnabled "nnn" config) {
			description = "Show whether the shell is being accessed inside NNN";
			format = "[]($style inverted)[ $env_value \${symbol} ]($style)";
			style = "bg:cyan fg:black";
			symbol = "n³";
			variable = "NNNLVL";
		};

		VIM = lib.optionalAttrs (outputs.lib.config.isAnyProgramEnabled ["neovim" "vim"] config) {
			description = "Show whether the shell is being accessed inside (Neo)Vim";
			format = "[]($style inverted)[ \${symbol} ]($style)";
			style = "bg:green fg:black";
			symbol = "";
			variable = "VIMRUNTIME";
		};
	};
}
