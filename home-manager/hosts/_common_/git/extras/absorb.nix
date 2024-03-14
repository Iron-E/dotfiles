{ pkgs, ... }: {
	imports = [];

	home.packages = with pkgs; [ git-absorb ];
}
