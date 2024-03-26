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
				nixd
				rust-analyzer
				sqls
				tailwindcss-language-server
				vscode-langservers-extracted
				yaml-language-server
			;

			inherit (pkgs.nodePackages_latest)
				# cssmodules-ls # SEE: https://github.com/NixOS/nixpkgs/blob/nixos-23.11/doc/languages-frameworks/javascript.section.md
				bash-language-server
				graphql-language-service-cli
				pyright
				typescript-language-server
				vscode-json-languageserver
			;
		};
	};
}
