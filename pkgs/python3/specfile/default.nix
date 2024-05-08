{ lib
, fetchFromGitHub
, python3Packages
}: let
	owner = "packit";
	pname = "specfile";
	version = "0.28.2";

	rpm = python3Packages.rpm;
in python3Packages.buildPythonPackage {
	inherit pname version;
	pyproject = true;

	passthru = { inherit rpm; };

	src = fetchFromGitHub {
		inherit owner;
		repo = pname;
		rev = version;
		hash = "sha256-cjkbNvUYzJsUObkrjW0SKrVN++MOOwAs0xZcUb+v83A=";
	};

	build-system = with python3Packages; [ setuptools setuptools-scm ];
	dependencies = [ rpm ];

	meta = {
		description = "A library for parsing and manipulating RPM spec files";
		homepage = "https://github.com/${owner}/${pname}";
		license = with lib.licenses; [ mit ];
		mainProgram = pname;
	};
}
