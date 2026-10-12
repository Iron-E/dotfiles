{
  lib,
  fetchFromGitHub,
  buildGoModule,
  ...
}:
buildGoModule (finalAttrs: {
  pname = "ctrld";
  version = "1.5.8";

  src = fetchFromGitHub {
    owner = "Control-D-Inc";
    repo = "ctrld";
    tag = "v${finalAttrs.version}";
    hash = "sha256-/Wm4+ApQka4d0wcZ6lOSpR/Ai2rrQxOesX1A2rKkQeY=";
  };

  vendorHash = "sha256-zWfucQ3kR/GofRXAPBjZyWStiKA3uxIsCUqLFNtlWvU=";

  ldflags = [
    "-s"
    "-w"
  ];

  doCheck = false; # uses networking

  meta = {
    description = "ControlD";
    homepage = "https://controld.com";
    license = lib.licenses.mit;
    mainProgram = finalAttrs.pname;
  };
})
