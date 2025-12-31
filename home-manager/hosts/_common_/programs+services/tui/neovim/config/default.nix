{
  lib,
  pkgs,
  config,
  ...
}:
let
  package = type: name: config.${type}.${name}.package;
  prg = package "programs";
  srv = package "services";
in
{
  imports = [ ];

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

    extraLuaPackages =
      luaPkgs: with luaPkgs; [
        jsregexp # for luasnip
      ];

    extraPackages = builtins.attrValues (
      {
        ########
        # misc #
        ########

        inherit (pkgs)
          bat # previewer
          fd # fuzzy finder
          ;

        gh = prg "gh"; # octo.nvim
        git = prg "git"; # cloning plugins
        ripgrep = prg "ripgrep"; # `:Grep`

        ##############
        # Formatters #
        ##############

        inherit (pkgs)
          csharpier
          go-jsonnet
          gojq
          gotools # for goimports
          nixfmt-rfc-style
          opentofu
          prettierd
          rustfmt
          rustywind
          stylua
          ;

        ####################
        # Language Servers #
        ####################

        inherit (pkgs)
          basedpyright
          deno
          docker-language-server
          emmet-language-server
          go # required for nvim-lspconfig's gopls support
          gopls
          helm-ls
          jdt-language-server
          jsonnet-language-server
          lua-language-server
          marksman
          nixd
          roslyn-ls
          rust-analyzer
          sqls
          tailwindcss-language-server
          terraform-ls
          tinymist
          tofu-ls
          vscode-css-languageserver
          vscode-json-languageserver
          yaml-language-server
          ;

        inherit (pkgs.nodePackages_latest)
          bash-language-server
          typescript-language-server
          ;

        ###########
        # Linters #
        ###########

        inherit (pkgs)
          ansible-lint
          buf
          deadnix
          dotenv-linter
          eslint_d
          fish
          golangci-lint
          hadolint
          htmlhint
          nix
          ruff
          shellcheck
          sqlfluff
          tflint
          trivy
          ;

        ###############
        # Tree Sitter #
        ###############

        inherit (pkgs) clang tree-sitter;
        inherit (pkgs.nodePackages_latest) nodejs;
      }
      // (lib.optionalAttrs (!pkgs.stdenv.isDarwin) {
        inherit (pkgs)
          brightnessctl # mappings
          ;

        redshift = (srv "redshift"); # `:Redshift` command
      })
    );
  };
}
