#!/usr/bin/env fish

argparse (fish_opt -s d -l dry-run) (fish_opt -s h -l help) (fish_opt -s l -l link) -- $argv

set -l operation ''
if [ -n "$_flag_dry_run" ]
	set operation 'build'
else
	set operation 'switch'
end

if [ -n "$_flag_help" ] || [ -z "$argv[1]" ]
	echo  "
Usage: switch.fish [OPTIONS] [USER]@[HOSTNAME] [-- [HOME-MANAGER OPTIONS]]

Example: switch.fish --dry-run iron-e@origin --show-trace

Options:
  -d, --dry-run  Show home-manager output instead of activating immediately
  -h, --help     Print help
  -l, --link     Link additional targets into place
"
	return
end

nix run .#home-manager -- $operation --impure --flake .#$argv[1] $argv[2..]

if [ -z "$_flag_link" ]
	return
end

set -l root_path (git rev-parse --show-toplevel)/home-manager/hosts/_common_/programs+services/tui/neovim/config/read-write
for dir in (find -L "$root_path" -mindepth 1 -maxdepth 1)
	set -l target_path $XDG_CONFIG_HOME/nvim/(basename $dir)
	if [ -n "$_flag_dry_run" ]
		echo "Linking $dir to $target_path"
	else
		ln -sf "$dir" "$target_path"
	end
end
