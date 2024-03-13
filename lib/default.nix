nixpkgs: # `flake`
{
	config = import ./config nixpkgs;
	fs = import ./fs nixpkgs;
	systems = import ./systems nixpkgs;
	util = import ./util nixpkgs;
}
