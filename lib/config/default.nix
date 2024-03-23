nixpkgs: # `flake`
let
	inherit (nixpkgs) lib;
	attrsets = import ../attrsets nixpkgs;

	getEnabled = builtins.getAttr "enable";
in {
	inherit getEnabled;

	declare =
	configDir: # the configuration dir
	home-manager: # `pkg` the home-manager install
	configsByHost: # `{[string]: {args: <special-args>, os: <nixos-config>, [string]: (architecture: <home-manager-config>)}}`
	# @returns {nixosConfigurations: …, homeConfigurations: …}
	let
		unpackConfig =
		hostname: # `string`
		configs: # `{args: <special-args>, os: <nixos-config>, [string]: (architecture: <home-manager-config>)}`
		let
			# special args
			argsKey = "args";
			args = configs.${argsKey};

			# the config dir for the host
			hostConfigDir = configDir + "/${hostname}";

			# nixos config
			osConfigKey = "os";
		in {
			homeConfigurations =
			let
				# non-home config keys
				filterKeys = [argsKey osConfigKey];

				# select the `<home-manager-config>` fns
				homeConfigsByUsername = lib.filterAttrs (n: v: !(builtins.any (k: k == n) filterKeys)) configs;

				# `home-manager` requires the `extraSpecialArgs` and `pkgs` keys, which we can resolve automatically.
				# this also calls the `homeConfigFn` using `system` to resolve the real `homeConfig`
				mkHomeConfig =
				let deepDefaultHomeConfig = { extraSpecialArgs = args; }; # default home config parts which needs to be deeply merged
				in username: # `string`
					homeConfig: # `<home-manager-config>`
					let
						# default home config
						defaultHomeConfig = {
							pkgs = nixpkgs.legacyPackages.${args.system};
							modules = [(hostConfigDir + "/${username}")] ++ (lib.pipe ../../home-manager/modules [import builtins.attrValues]);
						};

						# recursively updates the deeply-nested defaults, and shallowly applies the shallow defaults
						mergedHomeConfig = (lib.recursiveUpdate homeConfig deepDefaultHomeConfig) // defaultHomeConfig;
					in home-manager.lib.homeManagerConfiguration
						mergedHomeConfig
				;
			in lib.mapAttrs'
				(username: homeConfig: lib.nameValuePair "${username}@${hostname}" (mkHomeConfig username homeConfig))
				homeConfigsByUsername
			;

			nixosConfigurations = attrsets.optionalMapByPath [osConfigKey] configs (osConfig: let
				# the default os configuration
				defaultOsConfig = {
					specialArgs = args;
					modules = [
						nixpkgs.nixosModules.notDetected # extra hardware detection
						hostConfigDir
					];
				};

				mergedOsConfig = osConfig // defaultOsConfig;
			in {
				${hostname} = nixpkgs.lib.nixosSystem mergedOsConfig;
			})
			;
		};
	in lib.foldlAttrs
		(result: name: value: lib.recursiveUpdate result (unpackConfig name value))
		{ homeConfigurations = {}; nixosConfigurations = {}; }
		configsByHost
	;

	nixpkgs =
	flakesWithOverlays: # flake inputs that have overlays
	overlays: # regular overlays to apply
	extraConfig: # the nixpkgs config
	let
		defaultNixpkgsConfig = {
			config.allowUnfree = true;
			overlays = overlays ++ (map (lib.getAttrFromPath ["overlays" "default"]) flakesWithOverlays);
		};
	in if extraConfig == null then defaultNixpkgsConfig
		else lib.recursiveUpdate extraConfig defaultNixpkgsConfig
	;

	optionalIfAnyEnabled = # returns `attrset` if any in the `list` where `{ enabled = true; }`
	list: # see `optionalIfAny`
	attrset: # see `optionalIfAny`
		attrsets.optionalIfAny getEnabled list attrset
	;
}
