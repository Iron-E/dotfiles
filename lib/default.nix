# TODO: mkNixpkgsConfig fn
nixpkgs: # `flake`
{
	config = import ./config nixpkgs;
	systems = import ./systems nixpkgs;
	util = import ./util nixpkgs;
}
