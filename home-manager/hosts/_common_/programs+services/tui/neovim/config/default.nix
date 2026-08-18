{
  pkgs,
  config,
  outputs,
  ...
}:
let
  package = type: name: config.${type}.${name}.package;
  prg = package "programs";

  outPkg = name: outputs.packages.${pkgs.stdenv.system}.${name};
  spring-tools = outPkg "spring-tools";
in
{
  imports = [ ];

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
    extraWrapperArgs = [
      "--set"
      "SPRING_TOOLS_PATH"
      "${spring-tools.out}"
    ];

    extraPackages = builtins.attrValues {
      ########
      # misc #
      ########
      inherit spring-tools; # jdtls

      inherit (pkgs)
        bat # previewer
        fd # fuzzy finder
        ;

      gh = prg "gh"; # octo.nvim
      git = prg "git"; # cloning plugins
      lombok = outPkg "lombok"; # jdtls
      ripgrep = prg "ripgrep"; # `:Grep`

      ##############
      # Formatters #
      ##############

      inherit (pkgs)
        csharpier
        go-jsonnet
        gojq
        gotools # for goimports
        nixfmt
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
        bash-language-server
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
        # roslyn-ls
        rust-analyzer
        sqls
        tailwindcss-language-server
        terraform-ls
        tinymist
        tofu-ls
        tombi
        typescript-language-server
        vscode-css-languageserver
        vscode-json-languageserver
        yaml-language-server
        ;

      ###########
      # Linters #
      ###########

      inherit (pkgs)
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
        zizmor
        ;

      ###############
      # Tree Sitter #
      ###############

      inherit (pkgs) clang nodejs tree-sitter;
    };
  };
}
