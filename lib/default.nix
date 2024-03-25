nixpkgs: # `flake`
{
	attrsets = import ./attrsets nixpkgs;
	config = import ./config nixpkgs;
	fs = import ./fs nixpkgs;
	generators = import ./generators nixpkgs;
	lists = import ./lists nixpkgs;
	strings = import ./strings nixpkgs;
	systems = import ./systems nixpkgs;
}
