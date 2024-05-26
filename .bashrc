# ~/.bashrc: executed by bash(1) for non-login shells.

### DEFAULTS

# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
*i*) ;;
*) return ;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
  debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
xterm-color | *-256color) color_prompt=yes ;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
  if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
    # We have color support; assume it's compliant with Ecma-48
    # (ISO/IEC-6429). (Lack of such support is extremely rare, and such
    # a case would tend to support setf rather than setaf.)
    color_prompt=yes
  else
    color_prompt=
  fi
fi

if [ "$color_prompt" = yes ]; then
  PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
  PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm* | rxvt*)
  PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
  ;;
*) ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
  test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
  alias ls='ls --color=auto'
  #alias dir='dir --color=auto'
  #alias vdir='vdir --color=auto'

  alias grep='grep --color=auto'
  alias fgrep='fgrep --color=auto'
  alias egrep='egrep --color=auto'
fi

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# some more ls aliases
# alias ll='ls -alF'
# alias la='ls -A'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
  . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

export ARC_HOME="$HOME/arc"

# END DEFAULTS
# START ARC

#alias py='python3.12'
#alias python3='python3.12'
#alias python='python3.12'

### ALIASES

# MY SYNCED ALIASES - START
alias ,='cd -'
alias .....='cd ../../../../'
alias ....='cd ../../../'
alias ...='cd ../../'
alias ..='cd ..'
alias a='ansible'
alias ag='ansible-galaxy'
alias ap='ansible-playbook'
alias arc='sudo nano ~/arc/.bashrc && arccp'                                                              # modify bashrc
alias arccp='sudo cp ~/arc/.bashrc ~/.bashrc && source ~/.bashrc'                                         # copy arc bashrc to local
alias arcdn='cd ~/arc && git pull && cp .bashrc ~ && cd -'                                                # download arc repo and copy bashrc to local
alias arcpc='sudo cp ~/.bashrc ~/arc/.bashrc && cd ~/arc'                                                 # copy local bashrc to arc repo
alias arcup='cd ~/arc && git add . && git commit -m "update .bashrc" && git push && cp .bashrc ~ && cd -' # update arc repo and copy bashrc to local
alias b58='bun $ARC_HOME/src/b58.ts | tee /dev/stderr | tr -d '\n' | clip.exe && echo ""'
alias br='bun run --watch'
alias bsrc='source ~/.bashrc'                                                                             # source bashrc
alias bx='bunx'
alias c='clear'
alias cg='cargo'
alias co='code .'
alias cr='cockroach'
alias d='docker'
alias dc='cd -'
alias di='doctl' # digital ocean
alias dja='django-admin'
alias dm='docker-compose'
alias ds='docker swarm'
alias dedis='docker run -p 6379:6379 -it redis/redis-stack-server:latest'
alias duke='docker rm -f'                                                        # nuke a docker container
alias gc='gh repo clone'
alias glbt="echo 'branches' && git branch -avv && echo 'tags' && git tag -l -n1" # git list branches and tags
alias grid='ps -ef | grep'
alias grist='history | grep'
alias kc='kubectl'
alias l='ls'
alias la='ls -A'
alias ll='ls -alF'
alias mk='minikube'
alias nnid='bun $ARC_HOME/src/nnid.ts | tee /dev/stderr | tr -d '\n' | clip.exe && echo ""'
alias nord='nordvpn'
alias nr='npm run'
alias nr='npm run'
alias nuke='sudo rm -rf' # nuke a directory
alias nvcp='cp ~/arc/nvim/* ~/.config/nvim/'                     # copy ~/arc/nvim/* to ~/.config/nvim/*
alias pirm='pip uninstall -y'
alias pl='pulumi'
alias plu='pulumi up -y'
alias puke='pkill -f' # nuke all processes with a given name
alias rb='rebar3'
alias senv='source ~/.env' # source global .env
alias t='turso'
alias tf='terraform'
alias tfa='terraform apply -var-file=.tfvars'
alias tfd='terraform destroy -var-file=.tfvars'
alias tfi='terraform init'
alias tfp='terraform plan -var-file=.tfvars'
alias tg='tar -xzvf' # untar and unzip
alias tgz='tar -xzf'
alias trcp='tree | xclip -selection clipboard' # copy tree to clipboard
alias up='uplink'
alias uuid="uuidgen | tee /dev/stderr | tr -d '\n' | clip.exe"
alias v='nvim'
alias vc='vultr-cli'
alias venv='python -m venv .venv && source ./.venv/bin/activate' # create a virtual environment
alias vsrc='source .env && source .venv/bin/activate'
alias wr='wrangler'
# MY SYNCED ALIASES - END

# alias pip='pip3.12'
#
# alias py='python3.12'
# alias python3='python3.12'
# alias python='python3.12'

### ENVIRONMENT VARIABLES
# test if .env exists and source it, if not create it
if [ -f ~/.env ]; then
  source ~/.env
else
  touch ~/.env
fi

### EXPORTS

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH=$BUN_INSTALL/bin:$PATH
# GoLang
export GOROOT=/home/adam/.go
export PATH=$GOROOT/bin:$PATH
export GOPATH=/home/adam/go
export PATH=$GOPATH/bin:$PATH
source <(kubectl completion bash)
# Turso
export PATH="/home/adam/.turso:$PATH"
# Fly
export FLYCTL_INSTALL="/home/adam/.fly"
export PATH="$FLYCTL_INSTALL/bin:$PATH"
# Pulumi
export PATH=$PATH:$HOME/.pulumi/bin
# Cargo
source "$HOME/.cargo/env"
# Modular
export MODULAR_HOME="/home/adam/.modular"
export PATH="/home/adam/.modular/pkg/packages.modular.com_mojo/bin:$PATH"
# Wasmtime
export WASMTIME_HOME="$HOME/.wasmtime"
export PATH="$WASMTIME_HOME/bin:$PATH"
# Wasmer
export WASMER_DIR="/home/adam/.wasmer"
[ -s "$WASMER_DIR/wasmer.sh" ] && source "$WASMER_DIR/wasmer.sh"
export MODULAR_HOME="/home/adam/.modular"
export PATH="/home/adam/.modular/pkg/packages.modular.com_mojo/bin:$PATH"
# PATH
export PATH="/usr/local/bin:$PATH"
export PATH="$HOME/.local/bin:$PATH"
#CUDA
export CUDA_HOME=/usr/local/cuda-12.4
#export PATH=/usr/local/cuda/bin${PATH:+:${PATH}}
#export LD_LIBRARY_PATH=/usr/local/cuda/lib64${LD_LIBRARY_PATH:+:${LD_LIBRARY_PATH}}
export PATH=/usr/local/cuda-12.4/bin:$PATH
export LD_LIBRARY_PATH=/usr/local/cuda-12.4/lib64:$LD_LIBRARY_PATH

# NVM
#export NVM_DIR="$HOME/.nvm"
#[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
#[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
#Mojo
export MODULAR_HOME="$HOME/.modular"
export PATH="$MODULAR_HOME/pkg/packages.modular.com_mojo/bin:$PATH"
find-python-for-mojo() {
  libpath=$(python3 -c 'import sysconfig; print(sysconfig.get_config_var("LIBDIR"))')
  pythonlib=$(ls $libpath | grep "libpython3.*[0-9]\.so$")
  export MOJO_PYTHON_LIBRARY=${libpath}/${pythonlib}
}
mj() {
  find-python-for-mojo
  mojo $@
}
# deno
export DENO_INSTALL="$HOME/.deno"
export PATH="$DENO_INSTALL/bin:$PATH"

# asdf
. $HOME/.asdf/asdf.sh
. $HOME/.asdf/completions/asdf.bash

# go
export PATH=$PATH:/usr/local/go/bin
export GOPATH=$HOME/go
export GOBIN=$GOPATH/bin


### EVALS
#eval "$(thefuck --alias f --enable-experimental-instant-mode)"

### INSTALLS

# arc installer - install commonly used non-apt packages
arcin() {
  if [ "$#" -ne 1 ]; then
    echo "Usage: arcin <software>"
    return 1
  fi

  local software="$1"

  case $software in
  python3.12)
    sudo add-apt-repository ppa:deadsnakes/ppa -y
    sudo apt-get update
    sudo apt-get install python3.12 python3.12-distutils -y
    sudo apt-get install python3.12-dev python3.12-venv -y
    sudo apt-get install python3-pip -y
    ;;
  deno)
    curl -fsSL https://deno.land/x/install/install.sh | sh
    ;;
  poetry)
    curl -sSL https://install.python-poetry.org | python3 -
    ;;
    #thefuck)
    #sudo apt update
    #sudo apt install python3-dev python3-pip python3-setuptools
    #pip install --user thefuck --upgrade

    # briefly run once to set up settings.py
    #thefuck &
    #pid=$!
    #sleep 5
    #kill $pid

    # WSL-specific performance fix - ignore windows paths
    #sed -i "/excluded_search_path_prefixes/c\excluded_search_path_prefixes = ['/mnt', '/c']" "$HOME/.config/thefuck/settings.py"
  #    ;;
  bun)
    curl -fsSL https://bun.sh/install | bash
    ;;
  kubectl)
    curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
    curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl.sha256"
    echo "$(cat kubectl.sha256)  kubectl" | sha256sum --check
    sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl
    kubectl version --client
    rm -rf kubectl
    rm -rf kubectl.sha256
    ;;
  rustup)
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
    ;;
  #nvm)
  #  curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/master/install.sh | bash
  #  bsrc
  #  ;;
  ipfs)
    wget https://dist.ipfs.io/go-ipfs/v0.9.0/go-ipfs_v0.9.0_linux-amd64.tar.gz
    tar -xvzf go-ipfs_v0.9.0_linux-amd64.tar.gz
    cd go-ipfs
    sudo bash install.sh
    ipfs --version
    ;;
  node)
    ##sudo apt-get install nodejs npm
    #NODE_VERSION="21.6.1"
    ##NODE_VERSION="latest"
    #wget https://nodejs.org/dist/${NODE_VERSION}/node-v${NODE_VERSION}-linux-x64.tar.xz
    #sudo tar -C /usr/local --strip-components 1 -xJf node-v${NODE_VERSION}-linux-x64.tar.xz
    #rm -rf node-v${NODE_VERSION}-linux-x64.tar.xz
    
    curl -fsSL https://deb.nodesource.com/setup_21.x | sudo -E bash - &&\
    sudo apt-get install -y nodejs

    which node
    node --version
    which npm
    npm --version
    ;;
  gh)
    type -p curl >/dev/null || (sudo apt update && sudo apt install curl -y)
    curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | sudo dd of=/usr/share/keyrings/githubcli-archive-keyring.gpg &&
      sudo chmod go+r /usr/share/keyrings/githubcli-archive-keyring.gpg &&
      echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list >/dev/null &&
      sudo apt update &&
      sudo apt install gh -y
    ;;
  fly)
    curl -L https://fly.io/install.sh | sh
    ;;
  wasm)
    curl https://get.wasmer.io -sSfL | sh
    curl https://wasmtime.dev/install.sh -sSf | sh
    curl https://rustwasm.github.io/wasm-pack/installer/init.sh -sSf | sh
    ;;
  ngrok)
    curl -s https://ngrok-agent.s3.amazonaws.com/ngrok.asc |
      sudo tee /etc/apt/trusted.gpg.d/ngrok.asc >/dev/null &&
      echo "deb https://ngrok-agent.s3.amazonaws.com buster main" |
      sudo tee /etc/apt/sources.list.d/ngrok.list &&
      sudo apt update && sudo apt install ngrok
    ;;
  asdf)
    # install asdf package manager
    ASDF_VERSION="v0.13.1"
    sudo apt install curl git openssl unixodbc automake autoconf libncurses5-dev xsltproc fop xmllint wxwidgets -y
    git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch ${ASDF_VERSION}

    # add these to your .bashrc
    #$HOME/.asdf/asdf.sh
    #$HOME/.asdf/completions/asdf.bash

    bsrc # source bashrc
    ;;
  erlang)
    # install erlang
    asdf plugin add erlang https://github.com/asdf-vm/asdf-erlang.git
    asdf install erlang latest
    asdf global erlang latest

    # install rebar3
    asdf plugin-add rebar https://github.com/Stratus3D/asdf-rebar.git
    asdf install rebar latest
    asdf global rebar latest

    # install gleam
    asdf plugin-add gleam https://github.com/asdf-community/asdf-gleam.git
    asdf install gleam latest
    asdf global gleam latest

    # install elixir
    asdf plugin-add elixir https://github.com/asdf-vm/asdf-elixir.git
    asdf install elixir latest
    asdf global elixir latest

    # install hex
    yes | mix local.hex
    ;;
  ruby)

    # remove old versions of rvm
    #cd .rvm/src
    #sudo rm -rf yaml*

    # install rvm
    #curl -sSL https://rvm.io/mpapis.asc | gpg --import -
    #curl -sSL https://rvm.io/pkuczynski.asc | gpg --import -
    #curl -L https://get.rvm.io | bash -s stable --rails --autolibs=enable
    #rvm pkg install libyaml

    # install ruby with asdf
    #asdf plugin add ruby https://github.com/asdf-vm/asdf-ruby.git
    #asdf install ruby latest
    #asdf global ruby latest

    # install using apt
    sudo apt-get install ruby-full
    ruby -v
    sudo gem install bundler
    ;;
  tf)
    sudo apt-get update && sudo apt-get install -y gnupg software-properties-common
    wget -O- https://apt.releases.hashicorp.com/gpg |
      gpg --dearmor |
      sudo tee /usr/share/keyrings/hashicorp-archive-keyring.gpg
    gpg --no-default-keyring \
      --keyring /usr/share/keyrings/hashicorp-archive-keyring.gpg \
      --fingerprint
    echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] \
          https://apt.releases.hashicorp.com $(lsb_release -cs) main" |
      sudo tee /etc/apt/sources.list.d/hashicorp.list
    sudo apt update
    sudo apt-get install terraform
    ;;
  vagrant)
    wget -O- https://apt.releases.hashicorp.com/gpg | sudo gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg
    echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list
    sudo apt update && sudo apt install vagrant
    export VAGRANT_WSL_ENABLE_WINDOWS_ACCESS="1"
    export PATH="$PATH:/mnt/c/Program Files/Oracle/VirtualBox"

    ;;
  wg)
    sudo apt install wireguard
    ;;
  doctl)
    sudo snap install doctl
    ;;
  spotify)
    # curl -sS https://download.spotify.com/debian/pubkey_0D811D58.gpg | sudo apt-key add -
    # echo "deb http://repository.spotify.com stable non-free" | sudo tee /etc/apt/sources.list.d/spotify.list
    # sudo apt-get update && sudo apt-get install spotify-client
    sudo snap install spotify
    ;;
  code)
    sudo apt-get install wget gpg
    wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor >packages.microsoft.gpg
    sudo install -D -o root -g root -m 644 packages.microsoft.gpg /etc/apt/keyrings/packages.microsoft.gpg
    sudo sh -c 'echo "deb [arch=amd64,arm64,armhf signed-by=/etc/apt/keyrings/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" > /etc/apt/sources.list.d/vscode.list'
    rm -f packages.microsoft.gpg
    sudo apt install apt-transport-https
    sudo apt update
    sudo apt install code # or code-insiders
    ;;
  docker)
    sudo apt-get update
    sudo apt-get install apt-transport-https ca-certificates curl software-properties-common -y
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
    sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
    sudo apt-get update
    sudo apt-get install docker-ce docker-ce-cli containerd.io -y
    sudo usermod -aG docker $USER
    ;;
  minikube)
    curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64
    sudo install minikube-linux-amd64 /usr/local/bin/minikube
    rm -rf minikube-linux-amd64
    ;;
  discord)
    sudo apt install gdebi-core -y
    wget -O ~/discord.deb "https://discord.com/api/download?platform=linux&format=deb"
    sudo gdebi ~/discord.deb -n
    rm -rf ~/discord.deb
    ;;
  steam)
    sudo apt install steam -y
    ;;
  lutris)
    flatpak install flathub net.lutris.Lutris -y
    ;;
  nordvpn)
    curl -sSf https://downloads.nordcdn.com/apps/linux/install.sh | sh
    nordvpn login
    nordvpn set killswitch on
    nordvpn set autoconnect on
    nordvpn set notify on
    nordvpn set dns "1.1.1.1"
    nordvpn connect
    ;;
  nvidia)
    sudo add-apt-repository ppa:graphics-drivers/ppa
    sudo apt update
    sudo ubuntu-drivers autoinstall
    ;;
  cuda)
    wget https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2204/x86_64/cuda-ubuntu2204.pin
    sudo mv cuda-ubuntu2204.pin /etc/apt/preferences.d/cuda-repository-pin-600
    wget https://developer.download.nvidia.com/compute/cuda/12.3.2/local_installers/cuda-repo-ubuntu2204-12-3-local_12.3.2-545.23.08-1_amd64.deb
    sudo dpkg -i cuda-repo-ubuntu2204-12-3-local_12.3.2-545.23.08-1_amd64.deb
    sudo cp /var/cuda-repo-ubuntu2204-12-3-local/cuda-*-keyring.gpg /usr/share/keyrings/
    sudo apt-get update
    sudo apt-get -y install cuda-toolkit-12-3
    sudo apt-get install -y nvidia-kernel-open-545
    sudo apt-get install -y cuda-drivers-545
    ;;

  *)
    echo "Unsupported software: $software"
    return 1
    ;;
  esac
}

### FUNCTIONS

# make a directory and cd into it
mkcd() {
  mkdir -p "$1" && cd "$1"
}

# copy a file to the clipboard (wsl only)
cpf() {
  if [ $# -eq 0 ]; then
    echo "Usage: clip <file>"
    return 1
  fi

  if [ ! -f "$1" ]; then
    echo "Error: File '$1' not found."
    return 1
  fi

  cat "$1" | clip.exe
  echo "Contents of '$1' copied to clipboard."
}

# concatenate all files in a directory and pipe to the clipboard (wsl only)
folcon() {
  # Ensure a directory is provided
  if [ -z "$1" ]; then
    echo "No directory provided"
    return 1
  fi

  # Navigate to the specified directory
  cd "$1" || return

  # Initialize the variable to store the contents
  all_contents=""

  # Concatenate all files in the directory into the variable
  for file in *; do
    if [ -f "$file" ]; then
      all_contents+="### $file ###\n"
      all_contents+="$(cat "$file")\n"
    fi
  done

  # Optionally, you can do something with the $all_contents variable here
  # For example, echo it, pipe it to cmd.exe, or redirect to another command
  echo "$all_contents" | clip.exe
}

# copy a command to the clipboard
cpc() {
  if [ $# -eq 0 ]; then
    echo "Usage: cpc <command>"
    return 1
  fi

  # The "$@" expands into all the arguments provided to the function
  # The output is then piped into clip.exe to copy to the clipboard
  "$@" | clip.exe
  if [ $? -eq 0 ]; then
    echo "Output of the command '$*' copied to clipboard."
  else
    echo "Error: Command failed to execute."
    return 1
  fi
}

# print a filesize in human readable format
fsz() {
  wc -c <$1 | numfmt --to=iec-i --suffix=B --format="%9.2f"
}

# add an alias to .bashrc, with optional comment
ali() {
  if [ "$#" -lt 2 ]; then
    echo "Usage: bali <alias_name> '<alias_command>' [optional 'comment']"
    return 1
  fi

  local alias_name="$1"
  local alias_command="$2"
  local alias_comment="${3:-}" # Use the third parameter if provided, or default to an empty string

  if [[ "$alias_name" =~ \  ]]; then
    echo "Alias name cannot contain spaces."
    return 1
  fi

  # Properly escape the command to be inserted in .bashrc
  alias_command="${alias_command//\'/\'\"\'\"\'}" # Handle single quotes in the command

  # Trim leading/trailing whitespace from command
  alias_command=$(echo "$alias_command" | xargs)

  # Automatically add a '#' to comment if it's not empty and doesn't already start with one
  if [[ -n "$alias_comment" && ! "$alias_comment" == \#* ]]; then
    alias_comment="# $alias_comment"
  fi

  local alias_definition="alias $alias_name='$alias_command'"
  if [[ -n "$alias_comment" ]]; then
    alias_definition+=" $alias_comment"
  fi

  local temp_file=$(mktemp)
  local comment_separator="# MY SYNCED ALIASES"
  local start_marker="${comment_separator} - START"
  local end_marker="${comment_separator} - END"

  # Check for the existence of alias markers
  if ! grep -q "$start_marker" ~/.bashrc; then
    echo "$start_marker" >>~/.bashrc
    echo "$end_marker" >>~/.bashrc
  fi

  # Check if alias already exists
  if grep -q "alias $alias_name=" ~/.bashrc; then
    echo "Alias $alias_name already exists. Do you want to overwrite it? (y/n)"
    read -r overwrite
    if [[ "$overwrite" != "y" ]]; then
      echo "Aborting."
      return 1
    fi
    # Remove the existing alias
    sed -i "/alias $alias_name=/d" ~/.bashrc
  fi

  # Extract the alias block, without markers
  sed -n "/$start_marker/,/$end_marker/{//!p}" ~/.bashrc >"$temp_file"

  # Add the new alias
  echo "$alias_definition" >>"$temp_file"

  # Sort the alias block
  sort "$temp_file" -o "$temp_file"

  # Recreate the section with the sorted aliases
  sed -i "/$start_marker/,/$end_marker/{//!d}" ~/.bashrc # Remove old aliases
  sed -i "/$start_marker/r $temp_file" ~/.bashrc         # Read new aliases into place

  # Clean up
  rm "$temp_file"

  echo "Alias $alias_name added successfully."
}

# END ARC
PATH=~/.console-ninja/.bin:$PATH
# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/home/adam/miniconda3/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/home/adam/miniconda3/etc/profile.d/conda.sh" ]; then
        . "/home/adam/miniconda3/etc/profile.d/conda.sh"
    else
        export PATH="/home/adam/miniconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

export PATH="$HOME/.deno/bin:$PATH"
export PATH=$PATH:$HOME/depot_tools
export RUSTY_V8_MIRROR=$HOME/.cache/rusty_v8
#export RUSTY_V8_MIRROR=$RUSTY_V8_MIRROR


bs() {
    bash ".sh/$1"
}
export MOOTLINE_REPO="$HOME/mootline"
export CARGO_TARGET_DIR="$HOME/.cargo_target"
. "$HOME/.cargo/env"
PATH="~/n/bin/:$PATH"
PATH="$(npm config get prefix)/bin/:$PATH"
PATH="~/n/bin/:$PATH"
PATH="$(npm config get prefix)/bin/:$PATH"
