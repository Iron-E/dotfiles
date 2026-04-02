# This file defines overlays
{ ... }:
{
  # This one brings our custom packages from the 'pkgs' directory
  additions = final: _prev: import ../pkgs final;

  # This one contains whatever you want to overlay
  # You can change versions, add patches, set compilation flags, anything really.
  # https://nixos.wiki/wiki/Overlays
  modifications =
    final: prev:
    let
      vimix-icon = variant: prev.vimix-icon-theme.override { colorVariants = [ variant ]; };
      vimix-theme =
        variant:
        prev.vimix-gtk-themes.override {
          colorVariants = [ "dark" ];
          themeVariants = [ variant ];
        };
    in
    {
      vimix-gtk-theme-beryl = vimix-theme "beryl";
      vimix-icon-theme-beryl = vimix-icon "Beryl";

      # See: https://github.com/NixOS/nixpkgs/pull/504078
      neovim-unwrapped =
        (prev.neovim-unwrapped.override {
          treesitter-parsers = {
            c.src = prev.fetchurl {
              url = "https://github.com/tree-sitter/tree-sitter-c/archive/v0.24.1.tar.gz";
              hash = "sha256:25dd4bb3dec770769a407e0fc803f424ce02c494a56ce95fedc525316dcf9b48";
            };
            lua.src = prev.fetchurl {
              url = "https://github.com/tree-sitter-grammars/tree-sitter-lua/archive/v0.5.0.tar.gz";
              hash = "sha256:cf01b93f4b61b96a6d27942cf28eeda4cbce7d503c3bef773a8930b3d778a2d9";
            };
            vim.src = prev.fetchurl {
              url = "https://github.com/tree-sitter-grammars/tree-sitter-vim/archive/v0.8.1.tar.gz";
              hash = "sha256:93cafb9a0269420362454ace725a118ff1c3e08dcdfdc228aa86334b54d53c2a";
            };
            vimdoc.src = prev.fetchurl {
              url = "https://github.com/neovim/tree-sitter-vimdoc/archive/v4.1.0.tar.gz";
              hash = "sha256:020e8f117f648c8697fca967995c342e92dbd81dab137a115cc7555207fbc84f";
            };
            query.src = prev.fetchurl {
              url = "https://github.com/tree-sitter-grammars/tree-sitter-query/archive/v0.8.0.tar.gz";
              hash = "sha256:c2b23b9a54cffcc999ded4a5d3949daf338bebb7945dece229f832332e6e6a7d";
            };
            markdown.src = final.fetchurl {
              url = "https://github.com/tree-sitter-grammars/tree-sitter-markdown/archive/v0.5.3.tar.gz";
              hash = "sha256:df845b1ab7c7c163ec57d7fa17170c92b04be199bddab02523636efec5224ab6";
            };
          };
        }).overrideAttrs
          (
            finalAttrs: previousAttrs: {
              version = "0.12.0";
              src = prev.fetchFromGitHub {
                owner = "neovim";
                repo = "neovim";
                tag = "v${finalAttrs.version}";
                hash = "sha256-uWhrGAwQ2nnAkyJ46qGkYxJ5K1jtyUIQOAVu3yTlquk=";
              };
            }
          );

      # example = prev.example.overrideAttrs (oldAttrs: rec {
      # ...
      # });
    };
}
