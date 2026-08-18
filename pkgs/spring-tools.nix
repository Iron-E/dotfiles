{
  lib,
  stdenv,
  fetchzip,
  owner ? "spring-projects",
  repo ? "spring-tools",
  release ? "5.3.0.RELEASE",
  sha256 ? "sha256-uhEHIzXGq6Do2xUE+EuHkTIUL9Glsv2T/+5jBUbdx2k=",
  ...
}:
stdenv.mkDerivation (finalAttrs: {
  pname = "spring-tools";
  version = "2.3.0-RC2";

  src = fetchzip {
    url = "https://github.com/${owner}/${repo}/releases/download/${release}/vscode-spring-boot-${finalAttrs.version}.vsix";
    extension = "zip";
    stripRoot = false;
    sha256 = if sha256 == null || sha256 == "" then lib.fakeSh256 else sha256;
  };

  phases = [
    "installPhase"
    "patchPhase"
  ];

  installPhase = ''
    cp -R "$src" "$out"
  '';

  meta = {
    description = "Spring vscode extension";
    homepage = "https://github.com/${owner}/${repo}";
  };
})
