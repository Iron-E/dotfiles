{ inputs, outputs, config, lib, pkgs, ... }:
let
	util = outputs.lib;
	inherit (util.strings) multiline;

	iniList = builtins.concatStringsSep ", ";

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
				gci
				prettierd
				rustfmt
				rustywind
			;

			####################
			# Language Servers #
			####################

			inherit (pkgs)
				ansible-language-server
				csharp-ls
				docker-compose-language-service
				dockerfile-language-server-nodejs
				emmet-ls
				gleam
				gopls
				jdt-language-server
				lua-language-server
				nil
				pyright
				rust-analyzer
				sqls
				tailwindcss-language-server
				terraform-ls
				typst-lsp
				vscode-langservers-extracted
				yaml-language-server
			;

			inherit (pkgs.nodePackages_latest)
				bash-language-server
				graphql-language-service-cli
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
				vale
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

	# extra vale config

	home.activation.valeSync = lib.hm.dag.entryAfter ["linkGeneration"] (multiline /* sh */ ''
		run ${lib.getExe pkgs.vale} --config="${config.xdg.configHome}/vale/config.ini" sync
	'');

	xdg.configFile."vale/config.ini".text = lib.generators.toINIWithGlobalSection {} {
		globalSection = {
			MinAlertLevel = "suggestion";
			Packages = iniList ["alex"];
			StylesPath = "styles";
		};

		sections."*".BasedOnStyles = iniList ["Vale" "alex"];
	};
}
