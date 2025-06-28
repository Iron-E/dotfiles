{ ... }:
{
  imports = [ ];

  programs.ripgrep.arguments = [
    "--colors=path:none"
    "--colors=path:fg:0x95,0xC5,0xFF"
    "--colors=path:style:underline"

    "--colors=line:none"
    "--colors=line:fg:0xFF,0xA6,0xFF"

    "--colors=column:none"
    "--colors=column:fg:0x80,0x80,0x80"

    "--colors=match:none"
    "--colors=match:fg:0x99,0xFF,0x99"
    "--colors=match:style:underline"
  ];
}
