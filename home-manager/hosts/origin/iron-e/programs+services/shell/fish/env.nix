{ inputs, outputs, config, lib, pkgs, ... }:
let
	util = outputs.lib;
	inherit (util.strings) multiline;
in {
	imports = [];

	programs.fish.shellInit =
	let
		inherit (config) xdg;
	in multiline /* fish */ ''
		# Android

		## SDK
		set -gx ANDROID_HOME '/opt/android-sdk'
		set -gx ANDROID_SDK_HOME ${xdg.configHome}/android
		set -gx PATH $PATH $ANDROID_HOME/{build-tools, platform-tools, tools, tools/bin}

		# Arch
		set -gx ARCHFLAGS '-arch x86_64'

		# Diff
		set -gx DIFFPROG "$EDITOR"

		# Java
		set -gx JAVA_HOME /usr/lib/jvm/java-18-openjdk

		# Oracle
		set -gx ORACLE_HOME $HOME/Oracle
		set -gx TNS_ADMIN $ORACLE_HOME/network/admin/tnsnames.ora
	'';
}
