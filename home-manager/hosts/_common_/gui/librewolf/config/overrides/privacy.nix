{ inputs, outputs, config, lib, pkgs, ... }:
let
	util = outputs.lib;
	inherit (util.strings) multiline;
in {
	imports = [];

	programs.librewolf.settings = lib.mapAttrs' (n: lib.nameValuePair "privacy.${n}") {
		"annotate_channels.strict_list.enabled" = true;
		"clearOnShutdown.downloads" = false;
		"clearOnShutdown.formdata" = true;
		"clearOnShutdown.history" = false;
		"clearOnShutdown.siteSettings" = true;
		"donottrackheader.enabled" = true;
		"fingerprintingProtection" = true;
		"globalprivacycontrol.enabled" = true;
		"globalprivacycontrol.was_ever_enabled" = true;
		"history.custom" = true;
		"purge_trackers.enabled" = true;
		"query_stripping.enabled" = true;
		"query_stripping.enabled.pbmode" = true;
		"resistFingerprinting" = true;
		"resistFingerprinting.autoDeclineNoUserInputCanvasPrompts" = true;
		"resistFingerprinting.block_mozAddonManager" = true;
		"resistFingerprinting.letterboxing" = true;
		"resistFingerprinting.randomDataOnCanvasExtract" = true;
		"resistFingerprinting.randomization.daily_reset.enabled" = false;
		"resistFingerprinting.randomization.daily_reset.private.enabled" = true;
		"trackingprotection.emailtracking.enabled" = true;
		"trackingprotection.enabled" = true;
		"trackingprotection.lower_network_priority" = true;
		"trackingprotection.socialtracking.enabled" = true;
	};
}
