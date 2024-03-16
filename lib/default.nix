nixpkgs: # `flake`
{
	attrsets = import ./attrsets nixpkgs;
	config = import ./config nixpkgs;
	fs = import ./fs nixpkgs;
	strings = import ./strings nixpkgs;
	systems = import ./systems nixpkgs;
}
