# run with: source ~/arc/.bashrc

cp $HOME/arc/.bashrc $HOME/.bashrc
source $HOME/.bashrc

yes | arcin python3.12
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

ID=96557890
NAME="kahnpoint"
git config --global user.name "${NAME}"
git config --global user.email "${ID}+${NAME}@users.noreply.github.com"


bsrc