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

	# TODO: remove when roslyn-ls updates
	nixpkgs.config.permittedInsecurePackages = [ "dotnet-sdk-6.0.428" ];

	# these are the runtime dependencies of my neovim config
	programs.neovim = {
		withNodeJs = false;
		withPython3 = false;
		withRuby = false;

		extraLuaPackages = luaPkgs: with luaPkgs; [
			jsregexp # for luasnip
		];

		extraPackages = builtins.attrValues ({
			########
			# misc #
			########

			inherit (pkgs)
				bat # previewer
				cmake # telescope-fzf-native build
				fd # fuzzy finder
				xclip # clipboard
			;

			gh = prg "gh"; # octo.nvim
			git = prg "git"; # cloning plugins
			ripgrep = prg "ripgrep"; # `:Grep`

			##############
			# Formatters #
			##############

			inherit (pkgs)
				csharpier
				gci
				go-jsonnet
				gojq
				prettierd
				rustfmt
				rustywind
			;

			####################
			# Language Servers #
			####################

			inherit (pkgs)
				ansible-language-server
				docker-compose-language-service
				dockerfile-language-server-nodejs
				emmet-language-server
				gopls
				harper
				jdt-language-server
				jsonnet-language-server
				lua-language-server
				nixd
				pyright
				roslyn-ls
				rust-analyzer
				sqls
				tailwindcss-language-server
				terraform-ls
				tinymist
				vscode-langservers-extracted
				yaml-language-server
			;

			inherit (pkgs.nodePackages_latest)
				bash-language-server
				typescript-language-server
				vscode-json-languageserver
			;

			###########
			# Linters #
			###########

			inherit (pkgs)
				ansible-lint
				deadnix
				dotenv-linter
				eslint_d
				fish
				golangci-lint
				htmlhint
				nix
				ruff
				shellcheck
				sqlfluff
				tflint
				tfsec
			;

			###############
			# Tree Sitter #
			###############

			inherit (pkgs) clang tree-sitter;
			inherit (pkgs.nodePackages_latest) nodejs;
		} // (lib.optionalAttrs (!pkgs.stdenv.isDarwin) {
			inherit (pkgs)
				brightnessctl # mappings
			;

			redshift =  (srv "redshift"); # `:Redshift` command
		}));
	};
}
