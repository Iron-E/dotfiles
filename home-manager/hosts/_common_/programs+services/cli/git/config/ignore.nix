{ ... }:
{
  imports = [ ];

  programs.git.ignores = [
    "**/*.bak"
    "**/*.log"
    "**/*.orig"
    "**/*.pyc"
    "**/*.swp"
    "**/*.temp"
    "**/*.tmp"
    "**/*~"
    "**/.env"
    "**/.envrc"
    "**/.nvim.lua"
    "**/.nvim/"
    "**/bar"
    "**/bar.*"
    "**/baz"
    "**/baz.*"
    "**/foo"
    "**/foo.*"
    "**/node_modules/"
    "**/.session.vim"
  ];
}
