{ lib
, buildFHSEnv
, callPackage
, writeShellScript
, rpm-spec-language-server ? callPackage ./bin.nix {}
,
}: let
	name = "rpm-spec-language-server";
in buildFHSEnv {
	inherit name;
	runScript = lib.getExe rpm-spec-language-server;

	# Additional commands to be executed for finalizing the directory structure.
	extraBuildCommands = /* sh */ ''
		mkdir -p "$out/var/lib/rpm"
		exec "${lib.getExe' rpm-spec-language-server.rpm "rpmdb"}" --initdb --dbpath "$out/var/lib/rpm"
	'';
}
