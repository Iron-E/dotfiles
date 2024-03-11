# TODO: mkNixpkgsConfig fn
nixpkgs: # `flake`
let
	inherit (nixpkgs) lib;

	optionalMapAttrByPath =
	attrPath: # string[]
	set: # attrset
	fn: # `attrset: any`
	# @returns output of `fn` or empty set
	let attrs = lib.attrByPath attrPath null set;
	in if attrs == null then {}
		else fn attrs
	;

in {
	inherit optionalMapAttrByPath;
	systems = import ./systems.nix nixpkgs;

	mkConfig =
	home-manager: # `pkg` the home-manager install
	configDir:
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
			hostConfigDir = ./${configDir} + "/@${hostname}";

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
							modules = [(./${hostConfigDir}/${username})];
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

			nixosConfigurations = optionalMapAttrByPath [osConfigKey] configs (osConfig: let
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
}
