nixpkgs: # `flake`
let
	inherit (nixpkgs) lib;
	inherit (lib) const filterAttrs flip foldlAttrs getAttrFromPath mapAttrs' nameValuePair pipe recursiveUpdate;

	attrsets = import ../attrsets nixpkgs;

	getEnabled = builtins.getAttr "enable";

	mkArgs' = # generate `specialArgs` / `extraSpecialArgs`
	args: # `attrset`, must contain `architecture`
	let
		# remove `args.architecture` from final output, since it should be `args.targetPlatform.architecture`
		argsWithoutSys = filterAttrs (n: const (n != "architecture")) args;
	in
	os: /* the os name */ argsWithoutSys // {
		targetPlatform = {
			architecture = args.architecture;
			isDarwin = os == "darwin";
			isGenericLinux = os == "linux";
			isNixOS = os == "nixos";
		};
	};
in {
	inherit getEnabled mkArgs';

	declare =
	repoDir: # the configuration dir
	home-manager: # `pkg` the home-manager install
	configsByHost: # `{[string]: {args: <special-args>, os: <nixos-config>, [string]: (architecture: <home-manager-config>)}}`
	# @returns {nixosConfigurations: …, homeConfigurations: …}
	let
		homeManagerModules = (pipe ../../home-manager/modules [import builtins.attrValues]);

		unpackConfig =
		hostname: # `string`
		configs: # `{args: <special-args>, os: <nixos-config>, [string]: (architecture: <home-manager-config>)}`
		let
			# special args
			argsKey = "args";
			args = configs.${argsKey};

			# nixos config
			osConfigKey = "os";

			mkArgs = mkArgs' args; # generate `specialArgs` / `extraSpecialArgs`
		in {
			homeConfigurations =
			let
				homeConfigDir = repoDir + "/home-manager/hosts/${hostname}";
				homeConfigsByUsername = # select the `<home-manager-config>` fns
				let
					filterKeys = n: !(builtins.elem n [argsKey osConfigKey]);
				in
					filterAttrs
					(flip pipe [filterKeys const])
					configs
				;

				# `home-manager` requires the `extraSpecialArgs` and `pkgs` keys, which we can resolve automatically.
				# this also calls the `homeConfigFn` using `architecture` to resolve the real `homeConfig`
				mkHomeConfig =
				let deepDefaultHomeConfig = { extraSpecialArgs = mkArgs "linux"; }; # default home config parts which needs to be deeply merged
				in username: # `string`
					homeConfig: # `<home-manager-config>`
					let
						# default home config
						defaultHomeConfig = {
							pkgs = nixpkgs.legacyPackages.${args.architecture};
							modules = [(homeConfigDir + "/${username}")] ++ homeManagerModules;
						};

						# recursively updates the deeply-nested defaults, and shallowly applies the shallow defaults
						mergedHomeConfig = (recursiveUpdate homeConfig deepDefaultHomeConfig) // defaultHomeConfig;
					in home-manager.lib.homeManagerConfiguration
						mergedHomeConfig
				;
			in mapAttrs'
				(username: homeConfig: nameValuePair "${username}@${hostname}" (mkHomeConfig username homeConfig))
				homeConfigsByUsername
			;

			nixosConfigurations = attrsets.optionalMapByPath [osConfigKey] configs (osConfig:
			let
				specialArgs = mkArgs "nixos";
				defaultOsConfig = {
					inherit specialArgs;
					system = args.architecture;
					modules = [
						nixpkgs.nixosModules.notDetected # extra hardware detection
						(repoDir + "/nixos/hosts/${hostname}") # the config for the host

						home-manager.nixosModules.home-manager # home-manager module
						{ # home-manager default settings
							home-manager = {
								sharedModules = homeManagerModules; # import home manager modules
								useUserPackages = true; # likely to become default value in the future
							};
						}
					];
				};

				mergedOsConfig = osConfig // defaultOsConfig;
			in {
				${hostname} = nixpkgs.lib.nixosSystem mergedOsConfig;
			})
			;
		};
	in foldlAttrs
		(result: name: value: recursiveUpdate result (unpackConfig name value))
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
			overlays = overlays ++ (map (getAttrFromPath ["overlays" "default"]) flakesWithOverlays);
		};
	in if extraConfig == null then defaultNixpkgsConfig
		else recursiveUpdate extraConfig defaultNixpkgsConfig
	;

	optionalIfAnyEnabled = # returns `attrset` if any in the `list` where `{ enabled = true; }`
	list: # see `optionalIfAny`
	attrset: # see `optionalIfAny`
		attrsets.optionalIfAny getEnabled list attrset
	;
}
