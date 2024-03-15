nixpkgs: # flake
{
	# return `value` as a list if it wasn't already
	singleton = value: if builtins.isList value then value else [value];
}
