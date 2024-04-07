{ inputs, outputs, config, lib, pkgs, ... }:
let
	util = outputs.lib;
	inherit (util.strings) multiline;

	package = type: name: config.${type}.${name}.package;
	prg = package "programs";
	srv = package "services";
in {
	imports = [];

	# my neovim config manages itself (but is not self-contained, see below)
	xdg.configFile.nvim = {
		source = ./read-only;
		recursive = true;
	};

	# these are the runtime dependencies of my neovim config
	programs.neovim = {
		withNodeJs = false;
		withPython3 = false;
		withRuby = false;
		extraPackages = builtins.attrValues {
			########
			# misc #
			########

			inherit (pkgs)
				bat # previewer
				brightnessctl # mappings
				clang # treesitter parsers
				cmake # telescope-fzf-native build
				fd # fuzzy finder
				xclip # clipboard
			;

			git = prg "git"; # cloning plugins
			redshift = srv "redshift"; # `:Redshift` command
			ripgrep = prg "ripgrep"; # `:Grep`

			#######
			# LSP #
			#######

			inherit (pkgs)
				csharp-ls
				emmet-ls
				gopls
				jdt-language-server
				lua-language-server
				nil
				rust-analyzer
				sqls
				tailwindcss-language-server
				typst-lsp
				vscode-langservers-extracted
				yaml-language-server
			;

			inherit (pkgs.nodePackages_latest)
				bash-language-server
				graphql-language-service-cli
				pyright
				typescript-language-server
				vscode-json-languageserver
			;
		};
	};
}
