# Iron-E's dotfiles

These are my dotfiles, written in Nix using `home-manager`. Derived from [nix-starter-configs](https://github.com/Misterio77/nix-starter-configs).

My old dotfiles can be found [here](https://gitlab.com/Iron_E/dotfiles/).

> [!WARNING]
>
> Stability is not guaranteed for anyone but me, and breaking changes may arrive unannounced.
>
> You may use this as a baseline for your own config, but it would be unwise to use it as a distribution!

## Requirements

Requirements:

* `dconf` (for `home-manager` activation script)
* `nix` (for `home-manager`)

Add these lines to your `nix.conf`:

```ini
experimental-features = nix-command flakes
```

### Optional

#### Wezterm

On non-NixOS systems:

* `wezterm-terminfo` (or else `wezterm` looks weird)

#### xorg

On all systems:

* `xauth` (must be installed system-wide)
* `xinit` / `startx` (I don't use a display manager)

##### i3

On all systems:

* `alsa-utils` for volume control
* `libpulse` for volume control
* `xsecurelock` for lock screen (must be installed system-wide)

## Usage

### …as dotfiles

To build a configuration:

```sh
# NOTE: `--impure` is required for `nixGL`. The rest of the configuration does not perform any impure action.
nix run .#home-manager --  build --impure --flake .#<user>@<hostname> --show-trace
```

To deploy a configuration to your home directory:

```sh
# NOTE: `--impure` is required for `nixGL`. The rest of the configuration does not perform any impure action.
# WARN: existing files will be saved as `.backup`s
nix run .#home-manager -- switch -b backup --impure --flake .#<user>@<hostname>
```

### …as flake input

```nix
{
	inputs.nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable"; # or some other link
	inputs.dotfiles = {
		url = "github:Iron-E/dotfiles";
		inputs.nixpkgs.follows = "nixpkgs";
	};

	outputs = inputs @ { self, nixpkgs, dotfiles }: {
		# define outputs
	};
}
```

#### `home-manager` modules

This repository defines a `homeManagerModules` output, which can be used to access the home-manager modules (not the configs!) which are used by these dotfiles.

##### `nixgl`

An implementation of https://github.com/nix-community/nixGL/issues/114#issuecomment-1585323281.

Provides the options:

| Name           | Type  | Default | Description                                                                                     |
| :--            | :--   | :--     | :--                                                                                             |
| `nixgl.prefix` | `str` | `""`    | Will be prepended to commands which are wrapped with nixGL. Should be set on non-NixOS systems. |

Provides the outputs:

| Name                    | Type         | Description                                                                     |
| :--                     | :--          | :--                                                                             |
| `config.lib.nixgl.prefix` | `pkg -> pkg` | Can be used to wrap a package with nixGL. See the aforementioned issue comment. |

Example:

```nix
{ inputs, outputs, config, lib, pkgs, ... }: {
	nixpkgs = { overlays = [inputs.nixgl.overlays.default]; }; # make sure `nixgl` is a flake input

	nixgl.prefix = lib.getExe' pkgs.nixgl.auto.nixGLDefault "nixGL";
	home.packages = [(config.lib.nixgl.wrap pkgs.wezterm)];
}
```

#### Hosts

The dotfiles provide a `hosts` output that is a path to the [hosts](./home-manager/hosts) directory in the nix store. This can be used to import the `dotfiles` in a NixOS config and integrate this standalone home-manager config into a home-manager NixOS module config.

#### Lib

The dotfiles provide a `lib` output, but:

* you'll have to read the source code (I'm not documenting the lib of my dotfiles, sorry!); and
* heed the warning at the top of this README.

#### Overlays

The dotfiles provide an `overlays` output.

##### Additions

The `overlays.additions` output is additional packages defined in this repository that can be overlayed onto nixpkgs.

##### Modifications

`overlays.modifications` which are customized existing nix packages.

###### nerdfonts-symbols

The `nerdfonts` nix package, with only symbols included.
