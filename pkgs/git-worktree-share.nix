{
  lib,
  stdenv,
  fetchurl,
  owner ? "keithamus",
  repo ? "git-worktree-share",
  ...
}:
let
  pname = "git-worktree-share";
in
stdenv.mkDerivation (finalAttrs: {
  inherit pname;
  version = "115db1292bcff21168b298b143aed40fe2cef436";

  src = fetchurl {
    url = "https://raw.githubusercontent.com/${owner}/${repo}/${finalAttrs.version}/bin/git-worktree-share";
    sha256 = "97dec1d4b1f0098e264f52ae22ba692a43420559bb1e3eb9a0702ba9c95a0ec2";
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
    description = "Share untracked files across git worktrees easily";
    homepage = "https://github.com/${owner}/${repo}";
    license = with lib.licenses; [ mit ];
    mainProgram = finalAttrs.pname;
  };
})
