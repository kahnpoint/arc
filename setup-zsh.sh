#!/bin/bash

# set git global config
ID=96557890
NAME="kahnpoint"
git config --global user.name "${NAME}"
git config --global user.email "${ID}+${NAME}@users.noreply.github.com"
git config --global init.defaultBranch main


# copy arc zshrc to local
cp ~/arc/.zshrc ~/.zshrc
source ~/.zshrc

# Mac Adjustments

# Speed up Mission Control animations
defaults write com.apple.dock expose-animation-duration -float 0.1 && killall Dock

# Disable window resize animations
defaults write NSGlobalDomain NSAutomaticWindowAnimationsEnabled -bool false

# Speed up or disable Quick Look animations
defaults write -g QLPanelAnimationDuration -float 0

# Disable the "open/close" animation for apps
defaults write com.apple.dock launchanim -bool false && killall Dock

# Speed up the animation when opening files in Finder
defaults write com.apple.finder DisableAllAnimations -bool true && killall Finder

# Homebrew

# Install Homebrew for Apple Silicon
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Install Homebrew for Intel
arch -x86_64 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Alacritty
brew install alacritty
cp ~/arc/alacritty.toml ~/.config/alacritty/alacritty.toml
brew install font-hack-nerd-font

# JS
brew install node
brew install oven-sh/bun/bun

# Python
brew install python@3.12
brew install --cask anaconda

# Rust
brew install rust
brew install rustup

# Fly
brew install flyctl

# Wasmer
brew install wasmer

# Ngrok
brew install ngrok

# Github CLI
brew install gh

# Pulumi
brew install pulumi

# Docker
brew install docker

# Terraform
brew install terraform

# Kubernetes
brew install kubernetes-cli
brew install helm
brew install minikube
brew install kind
brew install kustomize

# Karabiner
softwareupdate --install-rosetta
brew install --cask rectangle
brew install --cask karabiner-elements
brew install yqrashawn/goku/goku
brew services start yqrashawn/goku/goku


# Misc
brew install yq
brew install jq
brew install fzf
brew install fd
brew install bat
brew install exa
brew install dust
brew install sd
