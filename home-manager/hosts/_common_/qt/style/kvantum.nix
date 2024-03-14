{ pkgs, ... }: {
	imports = [];

	qt.style.name = "kvantum";

	home.packages = with pkgs; [ arc-kde-theme ];
	xdg.configFile."Kvantum/kvantum.kvconfig".text = /* ini */ ''
[General]
theme=ArcDarker
'';
}
