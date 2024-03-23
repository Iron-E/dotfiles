args @ { config, lib, pkgs, ... }:
let
	cfg = config.nixgl;
	inherit (import ../../lib/strings args) multiline;
in {
	# SEE: https://github.com/nix-community/nixGL/issues/114#issuecomment-1585323281
	options.nixgl = {
		prefix = lib.mkOption {
			type = lib.types.str;
			default = "";
			description = ''
				Will be prepended to commands which require working OpenGL.

				This needs to be set to the right nixGL package on non-NixOS systems.
			'';
		};
	};

	config = {
		lib.nixgl.wrap =
		pkg:
		if cfg.prefix == "" then # return original pkg
			lib.warn "Refusing to wrap ${pkg.name} with nixGL because nixgl.prefix is not set" pkg
		else (pkg.overrideAttrs (old: { # Wrap the package's binaries with nixGL, while preserving the rest of the outputs and derivation attributes.
			name = "nixGL-${pkg.name}";
			buildCommand = multiline /* sh */ ''
				set -eo pipefail

				${
				# Heavily inspired by https://stackoverflow.com/a/68523368/6259505
				pkgs.lib.concatStringsSep "\n" (map (outputName: multiline /* sh */ ''
					echo "Copying output ${outputName}"
					set -x
					cp -rs --no-preserve=mode "${pkg.${outputName}}" "''$${outputName}"
					set +x
				'') (old.outputs or [ "out" ]))}

				rm -rf $out/bin/*
				shopt -s nullglob # Prevent loop from running if no files
				for file in ${pkg.out}/bin/*; do
					echo "#!${pkgs.bash}/bin/bash" > "$out/bin/$(basename $file)"
					echo "exec -a \"\$0\" ${cfg.prefix} $file \"\$@\"" >> "$out/bin/$(basename $file)"
					chmod +x "$out/bin/$(basename $file)"
				done
				shopt -u nullglob # Revert nullglob back to its normal default state
			'';
		}));
	};
}
