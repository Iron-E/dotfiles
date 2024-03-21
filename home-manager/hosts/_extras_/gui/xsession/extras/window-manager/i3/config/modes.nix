args @ { inputs, outputs, config, lib, pkgs, ... }:
let
	util = outputs.lib;
	inherit (lib) const flip genAttrs id pipe;
	inherit (util.attrsets) pair;
	inherit (util.strings) multiline;
	inherit (import ./lib/keys.nix args)
		down left right up escape return
		enterMode genDirectionMaps getVimDirection
		lhs lhsMod
	;

	resize = "resize";
in {
	imports = [];

	xsession.windowManager.i3.config = {
		keybindings.${lhsMod "r"} = enterMode resize;
		modes.${resize} =
		let
			mkPair = name: flip pipe [(pair name) const];
			mkAction = mkPair "action";
			mkAxis = mkPair "axis";

			directionInfo = util.attrsets.concat [
				(genAttrs [right down] (mkAction "grow"))
				(genAttrs [right left] (mkAxis "width"))
				(genAttrs [up down] (mkAxis "height"))
				(genAttrs [up left] (mkAction "shrink"))
			];

			genMaps = genDirectionMaps id lhs (v:
				let inherit (directionInfo.${v}) action axis;
				in "${resize} ${action} ${axis} 10 px or 10 ppt"
			);
		in util.attrsets.concat [
			(genAttrs [escape return (lhsMod "r")] (pipe "default" [enterMode const]))
			(genMaps getVimDirection)
			(genMaps id)
		];
	};
}
