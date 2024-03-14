nixpkgs: # `flake`
{
	attrsets = import ./attrsets nixpkgs;
	strings = import ./strings nixpkgs;
	config = import ./config nixpkgs;
	fs = import ./fs nixpkgs;
	systems = import ./systems nixpkgs;
}
