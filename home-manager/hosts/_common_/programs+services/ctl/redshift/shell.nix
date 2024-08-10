{ inputs, outputs, config, lib, pkgs, ... }:
let
	util = outputs.lib;
	inherit (util.strings) multiline;
in {
	imports = [];


	home.packages = lib.toList (
	let
		name = "rift";
	in pkgs.writeShellApplication {
		inherit name;

		runtimeInputs = with pkgs; [ redshift ];
		text = multiline /* sh */ ''
			case "''${1-}" in
				"blue")
					TEMPERATURE=5500
					;;
				"yellow")
					TEMPERATURE=3750
					;;
				"orange")
					TEMPERATURE=2000
					;;
				"red")
					TEMPERATURE=1300
					;;
				""|"-h")
					echo "rift (blue|yellow|orange|red|<INT>) [<OPACITY>]]"
					exit 0
					;;
				*)
					TEMPERATURE="$1"
					;;
			esac

			redshift -PO "''$TEMPERATURE" -b "''${2:-1.0}"
		'';
	});
}
