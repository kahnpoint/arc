# This script is for setting up a new Ubuntu machine for Flutter development
# It expects arc/.bashrc to be sourced

## Update and upgrade
sudo apt-get update -y && sudo apt-get upgrade -y

## Install basic tools
sudo apt-get install -y curl git unzip xz-utils zip libglu1-mesa

# Linux 
sudo apt-get install -y \
      clang cmake git \
      ninja-build pkg-config \
      libgtk-3-dev liblzma-dev \
      libstdc++-12-dev inotify-tools

# Android SDK (Windows)
## Install SDK from https://developer.android.com/studio/index.html

# Android SDK (Linux)

## Install dependencies
sudo apt-get install -y \
    libc6:amd64 libstdc++6:amd64 \
    libbz2-1.0:amd64 libncurses5:amd64
    openjdk-11-jdk-headless gradle fswatch
sudo update-alternatives --config java
    
## Download Android SDK
cd ~
curl https://dl.google.com/android/repository/commandlinetools-linux-8512546_latest.zip -o /tmp/cmd-tools.zip
mkdir -p android/cmdline-tools
unzip -q -d android/cmdline-tools /tmp/cmd-tools.zip
mv android/cmdline-tools/cmdline-tools android/cmdline-tools/latest
rm /tmp/cmd-tools.zip 

## Setup Android SDK
yes | sdkmanager --licenses
sdkmanager --update
sdkmanager "platforms;android-30" "build-tools;30.0.3"
sdkmanager --list

## Download Android Studio
cd /usr/local/
wget https://redirector.gvt1.com/edgedl/android/studio/ide-zips/2024.1.1.12/android-studio-2024.1.1.12-linux.tar.gz
tar -xvf android-studio-2024.1.1.12-linux.tar.gz
rm android-studio-2024.1.1.12-linux.tar.gz
bash android-studio/bin/studio.sh
flutter config --android-studio-dir="/usr/local/android-studio"

# flutter config --android-studio-dir="/mnt/c/Program Files/Android/Android Studio"


# Google Chrome 
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
sudo dpkg -i google-chrome-stable_current_amd64.deb
sudo apt-get install -f
google-chrome --version
rm google-chrome-stable_current_amd64.deb


# Should return "No issues found!"
flutter doctor

# Install serverpod cli
# dart pub global activate serverpod_cli

# Install rust bridge codegen
cargo install flutter_rust_bridge_codegen
# use like flutter_rust_bridge_codegen create my_app