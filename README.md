# Iron-E's dotfiles

These are my dotfiles, written in Nix using `home-manager`.

My old dotfiles can be found [here](https://gitlab.com/Iron_E/dotfiles/).

> [!WARNING]
>
> Stability is not guaranteed for anyone but me, and breaking changes may arrive unannounced.
>
> You may use this as a baseline for your own config, but it would be unwise to use it as a distribution!

## Requirements

Requirements:

* `dconf`
* `nix`
* `startx` (for i3)

Add these lines to your `nix.conf`:

```ini
experimental-features = nix-command flakes
```

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

TODO: instructions

#### `home-manager` modules

TODO: instructions

#### `lib`

TODO: instructions

#### Overlays

TODO: instructions
