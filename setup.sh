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

if [ -f "~/.tmux/plugins/tpm/tpm" ]; then
  git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
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
        Yes ) stow --ignore setup -vt ~ */; break;;
        No ) echo "skipping symlinks"; break;;
    esac
done

echo "done"

