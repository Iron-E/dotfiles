{ inputs, outputs, config, lib, pkgs, ... }:
let
	util = outputs.lib;
	inherit (util.strings) multiline;
in {
	imports = [];

	programs.librewolf.settings = lib.mapAttrs' (n: lib.nameValuePair "dom.${n}") {
		"forms.autocomplete.formautofill" = false;
		"security.https_only_mode_ever_enabled" = true;
	};
}
