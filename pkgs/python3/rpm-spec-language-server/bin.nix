{ lib
, callPackage
, fetchFromGitHub
, python3Packages
, specfile ? callPackage ../specfile {}
,
}: let
	pname = "rpm-spec-language-server";
	owner = "dcermak";
	version = "0.0.1";
in python3Packages.buildPythonApplication {
	inherit pname version;
	pyproject = true;

	passthru = { inherit (specfile) rpm; };

	src = fetchFromGitHub {
		inherit owner;
		repo = pname;
		rev = version;
		hash = "sha256-X1xw/wyTls07fOzplaiGmVBFjgVimbIIDh3N+CF+LcE=";
	};

	build-system = with python3Packages; [ poetry-core ];
	dependencies = with python3Packages; [ pygls specfile ];

	postInstall = /* sh */ ''
		bin="$out/bin"
		mv "$bin/rpm_lsp_server" "$bin/rpm-spec-language-server"
	'';

	meta = {
		description = "Language Server for RPM spec files ";
		homepage = "https://github.com/${owner}/${pname}";
		license = with lib.licenses; [ gpl2Plus ];
		mainProgram = pname;
	};
}
