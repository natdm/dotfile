#!/bin/sh

# find out the os
unameOut="$(uname -s)"
case "${unameOut}" in
    Linux*)     machine="Linux";;
    Darwin*)    machine="Mac";;
    CYGWIN*)    machine="Cygwin";;
    MINGW*)     machine="MinGw";;
    *)          machine="UNKNOWN:${unameOut}"
esac

# exit if not a mac
if [ "$machine" != "Mac" ]; then
	echo "Expected a macbook"
	exit 1
fi

# install brew
if ! hash brew 2>/dev/null; then
	echo "Installing brew"
	curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh
else
	echo "Brew is already installed"
fi

# install brew bundle
if ! hash bundle 2>/dev/null; then
	echo "Installing bundle"
	brew tap Homebrew/bundle
else
	echo "Bundle is already installed"
fi

function powerline_fonts {
	# clone
	git clone https://github.com/powerline/fonts.git --depth=1
	# install
	cd fonts
	./install.sh
	# clean-up a bit
	cd ..
	rm -rf fonts
}

# Fist argument is the destination, second is the location
function create_symlink {
	if [[ -L "$1" ]]; then
		if [[ -e $1 ]]; then
			echo "$1 already linked"
		else
			echo "$1 is a bad symlink"
			unlink $1
		fi
	else
		if [[ -e $1 ]]; then
			# not a symlink, but exists -- move it
			echo "$1 exists and is not a symlink, moving it to $1_dep"
			eval " mv $1 $1_dep"
		fi
		echo "linking $1 and $2"
		eval " ln -s $2 $1"
		echo "done"
	fi
}

echo "Run brew bundle?"

select yn in "Yes" "No"; do
    case $yn in
        Yes ) brew bundle; break;;
        No ) echo "skipping brew bundle"; break;;
    esac
done

echo "Install powerline fonts?"

select yn in "Yes" "No"; do
    case $yn in
        Yes ) powerline_fonts; break;;
        No ) echo "skipping powerline_fonts"; break;;
    esac
done

echo "Create symlimks?"

select yn in "Yes" "No"; do
    case $yn in
        Yes ) stow --ignore setup -vt ~ *; break;;
        No ) echo "skipping symlinks"; break;;
    esac
done

echo "setting nvim as git editor"
git config --global core.editor nvim

echo "done"

