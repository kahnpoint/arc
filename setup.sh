# run with: source ~/arc/.bashrc


# use ~/arc/.bashrc as the source for this script
cp $HOME/arc/.bashrc $HOME/.bashrc
source $HOME/.bashrc


# install basic packages
sudo apt update
sudo apt install unzip


# arcin installations
# yes | arcin python3.12
yes | arcin bun
yes | arcin kubectl
yes | arcin rustup
yes | arcin gh
yes | arcin wasm
yes | arcin kubectl
yes | arcin tf
yes | arcin wg
yes | arcin doctl
yes | arcin fly


### notebooks
# this chunk needs to be run in the windows environment 
# on WSL for some reason
# python notebooks
sudo apt install python3.10-venv
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

# refresh bashrc
bsrc