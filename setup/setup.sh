#!/bin/bash

# set git global config
ID=96557890
NAME="kahnpoint"
git config --global user.name "${NAME}"
git config --global user.email "${ID}+${NAME}@users.noreply.github.com"
git config --global init.defaultBranch main

# Mac Adjustments

# Speed up Mission Control animationscurs
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

# Fonts
brew install font-hack-nerd-font

# Development
brew install --cask tableplus
brew install --cask visual-studio-code
brew install --cask conductor
brew install --cask claude-code
brew install --cask codex

# JS
brew install node
brew install oven-sh/bun/bun

# Python
brew install python@3.12
brew install --cask miniconda
conda init zsh
conda update conda

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
brew install --cask docker

# Terraform
brew install terraform

# Flutter 
## make sure xcode and android studio are installed
## install the android command-line tools as described in https://docs.flutter.dev/platform-integration/android/setup
brew install flutter
brew install ruby 
brew install cocoapods
sudo xcode-select --switch /Applications/Xcode.app/Contents/Developer
flutter doctor --android-licenses
brew install fswatch
brew install vitobotta/tap/hetzner_k3s
# be sure to set the vscode flutter sdk location to /opt/homebrew/share/flutter

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

# pipx
brew install pipx
pipx ensurepath
sudo pipx ensurepath --global

# Misc
brew install yq
brew install jq
brew install fzf
brew install fd
brew install bat
brew install exa
brew install dust
brew install sd
brew install coreutils
brew tap homebrew/autoupdate
brew autoupdate start
