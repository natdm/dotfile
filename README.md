# Dotfiles

Nates Dotfiles. These are loaded with [stow](https://www.gnu.org/software/stow/) (thanks Shaun).


- To load any of the folders to your home directory (using lua as an example): `stow -vt ~ ./neovimlua`
- To unload: `stow -Dvt ~ ./neovimlua`
- To install all `Brewfile` entries, make sure brew is installed and run `brew bundle`.

The setup script (`setup.sh`) should have all of this boilerplated, with some additional installs.

