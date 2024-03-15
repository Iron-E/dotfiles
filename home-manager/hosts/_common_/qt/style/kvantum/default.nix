args @ { inputs, outputs, lib, config, pkgs, ... }:
let
	kvantumLib = import ./lib args;
in kvantumLib.mkConfig {
}
