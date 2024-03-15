args @ { inputs, outputs, lib, config, pkgs, ... }:
let
	util = outputs.lib;
in {
	mkConfig = {
		theme ? import ../theme args, # the `theme`
		...
	}: {
			qt.style.name = "kvantum";
			home.packages = [ theme.package ];
			xdg.configFile."Kvantum/kvantum.kvconfig".text = # ini
''
[General]
theme=${theme.name}
''
			;
		}
	;
}
