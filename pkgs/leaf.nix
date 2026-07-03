{
  lib,
  stdenv,
  fetchurl,
  ...
}:
let
  pname = "leaf";
  repo = "https://github.com/RivoLink/${pname}";

  release =
    {
      aarch64-darwin = {
        name = "leaf-macos-arm64";
        sha = "c6fce84fb2ee9faec2e747db3fa826aedf7fc1aa922655109fb42578032727bd";
      };

      aarch64-linux = {
        name = "leaf-linux-arm64";
        sha = "b2326c0e968b2bc8ce705b555966582c70d41343d4661479e9affa210f2e8641";
      };

      x86_64-darwin = {
        name = "leaf-macos-x86_64";
        sha = "711e78205414a12efe2dc90d9371cd07a92744a7a769b7ec7c05204247a3fd93";
      };

      x86_64-linux = {
        name = "leaf-linux-x86_64";
        sha = "b985eefcfd0c4b74d72c0c5d7b9ffa4aec045022b49f09636c2388b57c0ce183";
      };
    }
    .${stdenv.hostPlatform.system};
in
stdenv.mkDerivation (finalAttrs: {
  inherit pname;
  version = "1.24.2";

  src = fetchurl {
    url = "${repo}/releases/download/${finalAttrs.version}/${release.name}";
    sha256 = release.sha;
  };

  phases = [
    "installPhase"
    "patchPhase"
  ];

  installPhase = ''
    mkdir -p $out/bin
    cp $src $out/bin/${finalAttrs.pname}
    chmod +x $out/bin/${finalAttrs.pname}
  '';

  meta = {
    description = "Terminal Markdown previewer — GUI-like experience.";
    homepage = repo;
    license = with lib.licenses; [ mit ];
    mainProgram = finalAttrs.pname;
  };
})
