{ inputs, outputs, config, lib, pkgs, ... }:
let
	util = outputs.lib;
	inherit (util.strings) multiline;
in {
	imports = [];

	xdg.configFile."maven/settings.xml".text = multiline /* xml */ ''
		<settings
			xmlns="http://maven.apache.org/SETTINGS/1.0.0"
			xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
			xsi:schemaLocation="http://maven.apache.org/SETTINGS/1.0.0 https://maven.apache.org/xsd/settings-1.0.0.xsd"
		>
		  <localRepository>${config.xdg.configHome}/maven/repository</localRepository>
		</settings>
	'';
}
