# run with: source ~/arc/.bashrc

# use ~/arc/.bashrc as the source for this script
cp $HOME/arc/.bashrc $HOME/.bashrc
source $HOME/.bashrc

# set hushlogin
touch /home/adam/.hushlogin 

# install basic packages
sudo apt update
sudo apt install unzip curl wget git build-essential -y

# arcin installations
# these may need to be run manually
yes | arcin python3.12
yes | arcin python3.11
arcin conda
yes | arcin bun
yes | arcin kubectl
yes | arcin rustup
yes | arcin gh
yes | arcin wasm
yes | arcin tf
yes | arcin wg
#yes | arcin doctl
yes | arcin fly
yes | arcin deno
yes | arcin node
yes | arcin docker
yes | arcin asdf
yes | arcin brew
yes | arcin buf

# kubuntu desktop apps
#yes | arcin spotify
#yes | arcin discord
#yes | arcin steam
#yes | arcin lutris
#yes | arcin code
#yes | arcin nordvpn
#sudo apt install vlc -y
#sudo apt install gimp -y
#sudo apt install inkscape -y
#sudo apt install blender -y

### notebooks
# this chunk needs to be run in the windows environment
# on WSL for some reason
# python notebooks
# sudo apt install python3.10-venv
pip install jupyterlab
pip install notebook
# typescript notebooks
npm install -g tslab
tslab install [--python=python3]
# rust notebooks
rustup component add rust-src
cargo install --locked evcxr_jupyter
evcxr_jupyter --install
jupyter kernelspec list

# set git global config
ID=96557890
NAME="kahnpoint"
git config --global user.name "${NAME}"
git config --global user.email "${ID}+${NAME}@users.noreply.github.com"
git config --global init.defaultBranch main

# refresh bashrc
bsrc

# # install nvim
# curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim.appimage
# chmod u+x nvim.appimage
# mv nvim.appimage /usr/local/bin/nvim

# # install vim-plug
# sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
#        https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'

# # create the init folder
# mkdir -p ~/.config/nvim/

# # build helix from source
# git clone https://github.com/helix-editor/helix.git
# cd helix
# sudo mv target/release/hx /usr/local/bin/

# # install helix
# sudo add-apt-repository ppa:maveonair/helix-editor
# sudo apt update
# sudo apt install helix
