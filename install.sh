#!/bin/bash


create_symlinks() {
    # Get the directory in which this script lives.
    script_dir=$(dirname "$(readlink -f "$0")")

    # Get a list of all files in this directory that start with a dot.
    files=$(find -maxdepth 1 -type f -name ".*")

    # Create a symbolic link to each file in the home directory.
    for file in $files; do
        name=$(basename $file)
        echo "Creating symlink to $name in home directory."
        rm -rf ~/$name
        ln -s $script_dir/$name ~/$name
    done
}

create_symlinks

echo "Installing fonts."
FONT_DIR="$HOME/.fonts"
git clone https://github.com/powerline/fonts.git $FONT_DIR --depth=1
cd $FONT_DIR
./install.sh

ZSH_CUSTOM="$HOME/.oh-my-zsh/custom"

echo "Installing zsh-autosuggestions"
git clone https://github.com/zsh-users/zsh-autosuggestions $ZSH_CUSTOM/plugins/zsh-autosuggestions

echo "Setting up the Spaceship theme."
git clone https://github.com/spaceship-prompt/spaceship-prompt.git "$ZSH_CUSTOM/themes/spaceship-prompt" --depth=1
ln -s "$ZSH_CUSTOM/themes/spaceship-prompt/spaceship.zsh-theme" "$ZSH_CUSTOM/themes/spaceship.zsh-theme"

echo "Checking if cursor command exists."
if ! command -v cursor &> /dev/null; then
    echo "cursor could not be found; skipping cursor extensions installation."
    exit 1
fi

echo "Installing cursor extensions."
cursor --install-extension ms-python.python \
     --install-extension ms-python.black-formatter \
     --install-extension dbaeumer.vscode-eslint \
     --install-extension esbenp.prettier-vscode \
     --install-extension eamodio.gitlens \
     --install-extension graphql.vscode-graphql \
     --install-extension hashicorp.terraform \
     --install-extension redhat.vscode-yaml \
     --install-extension github.vscode-github-actions \
     --install-extension yoavbls.pretty-ts-errors \
     --install-extension apollographql.vscode-apollo \
     --install-extension firsttris.vscode-jest-runner


