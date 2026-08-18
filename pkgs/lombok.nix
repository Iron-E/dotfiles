{
  lib,
  stdenv,
  fetchurl,
  sha256 ? "sha256-AfexoBXjPiti1fXzcFMwY1erFBX9GB/Lp3lPXRmMESY=",
  ...
}:
stdenv.mkDerivation (finalAttrs: {
  pname = "lombok";
  version = "1.18.46";

  src = fetchurl {
    url = "https://projectlombok.org/downloads/lombok-${finalAttrs.version}.jar";
    sha256 = if sha256 == null || sha256 == "" then lib.fakeSh256 else sha256;
  };

  phases = [
    "installPhase"
    "patchPhase"
  ];

  installPhase = ''
    mkdir -p "$out/bin"
    cp "$src" "$out/bin/${finalAttrs.pname}.jar"
    chmod +x "$out/bin/${finalAttrs.pname}.jar"
  '';

  meta = {
    description = "Project Lombok";
    homepage = "https://projectlombok.org";
    mainProgram = finalAttrs.pname;
  };
})
