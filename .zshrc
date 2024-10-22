export GOKU_EDN_CONFIG_FILE="$HOME/arc/goku.edn"

### ALIASES

# MY SYNCED ALIASES - START
alias .....='cd ../../../../'
alias ....='cd ../../../'
alias ...='cd ../../'
alias ..='cd ..'
alias arccp='sudo cp ~/arc/.zshrc ~/.zshrc && source ~/.zshrc' # copy arc zshrc to local
alias arcpc='sudo cp ~/.zshrc ~/arc/.zshrc && cd ~/arc' # copy local zshrc to arc repo
alias alacp='sudo cp ~/arc/alacritty.toml ~/.config/alacritty/alacritty.toml' # copy arc alacritty.toml to local
alias alapc='sudo mkdir -p ~/.config/alacritty && sudo cp ~/.config/alacritty/alacritty.toml ~/arc/alacritty.toml' # copy local alacritty.toml to arc repo
alias u32='bun $ARC_HOME/src/u32.ts | tee /dev/stderr | tr -d '\n' | pbcopy && echo ""'
alias u64='bun $ARC_HOME/src/u64.ts | tee /dev/stderr | tr -d '\n' | pbcopy && echo ""'
alias b58='bun $ARC_HOME/src/b58.ts | tee /dev/stderr | tr -d '\n' | pbcopy && echo ""'
alias b32='bun $ARC_HOME/src/b32.ts | tee /dev/stderr | tr -d '\n' | pbcopy && echo ""'
alias b='bun'
alias ba='bun add'
alias bf='bun run fmt'
alias bi='bun install'
alias big='bun install --global'
alias br='bun run'
alias brw='bun run --watch'
alias btw='bun test --watch'
alias bx='bunx'
alias zsrc='source ~/.zshrc' # source zshrc
alias c='clear'
alias ca='cargo add'
alias co='cursor .'
alias cf='cargo fmt'
alias cg='cargo'
alias ci='cargo install'
alias cw='cargo watch -c'
alias cr="cargo watch -c -x 'run  -- --nocapture'"
alias ct="cargo watch -c -x 'test -- --nocapture'"
alias d='docker'
alias dc='docker compose'
alias esrc='source ~/.env' # source global .env
alias duke='docker rm -f' # nuke a docker container
alias kb='karabiner'
alias nuke='sudo rm -rf' # nuke a directory
alias nr='npm run'
alias nv='nvim'
alias nvcp='cp ~/arc/kickstart.nvim ~/.kickstart.nvim' # copy ~/arc/kickstart.nvim to ~/.kickstart.nvim
alias oag='openapi-generator-cli'
alias pl='pulumi'
alias plu='pulumi up -y'
alias py='python3.12'
alias python='python3.12'
alias pip='pipx'
alias tlc='talosctl'
alias tf='terraform'
alias tfa='terraform apply -var-file=.tfvars'
alias tfd='terraform destroy -var-file=.tfvars'
alias tfi='terraform init'
alias tfp='terraform plan -var-file=.tfvars'
alias uuid="uuidgen | tee /dev/stderr | tr -d '\n' | pbcopy"
alias vn='vite-node'
alias vnw='vite-node --watch'
alias vt='vitest'
alias vtw='vitest --watch'
alias vsrc='source .env && source .venv/bin/activate'
alias wr='wrangler'
# MY SYNCED ALIASES - END

## PATH
# bun and vite-node/vitest
export PATH="$HOME/.bun/bin:$PATH"

## FUNCTIONS

# add an alias to .bashrc, with optional comment
ali() {
  if [ "$#" -lt 2 ]; then
    echo "Usage: ali <alias_name> '<alias_command>' [optional 'comment']"
    return 1
  fi

  local alias_name="$1"
  local alias_command="$2"
  local alias_comment="${3:-}"

  if [[ "$alias_name" =~ \  ]]; then
    echo "Alias name cannot contain spaces."
    return 1
  fi

  alias_command="${alias_command//\'/\'\"\'\"\'}"
  alias_command=$(echo "$alias_command" | xargs)

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

  if ! grep -q "$start_marker" ~/.zshrc; then
    echo "$start_marker" >> ~/.zshrc
    echo "$end_marker" >> ~/.zshrc
  fi

  if grep -q "alias $alias_name=" ~/.zshrc; then
    echo "Alias $alias_name already exists. Do you want to overwrite it? (y/n)"
    read -r overwrite
    if [[ "$overwrite" != "y" ]]; then
      echo "Aborting."
      return 1
    fi
    sed -i.bak "/alias $alias_name=/d" ~/.zshrc
  fi

  awk -v start="$start_marker" -v end="$end_marker" -v def="$alias_definition" '
    $0 ~ start {print; flag=1; next}
    $0 ~ end {if (flag) print def; flag=0; print; next}
    flag {print > "/tmp/aliases"}
    !flag {print}
  ' ~/.zshrc > "$temp_file"

  if [ -f "/tmp/aliases" ]; then
    sort "/tmp/aliases" >> "$temp_file"
    rm "/tmp/aliases"
  fi

  mv "$temp_file" ~/.zshrc

  echo "Alias $alias_name added successfully."
}

# cd to the previous directory
-(){
    cd - > /dev/null
}

# print a filesize in human readable format
fsz() {
  wc -c <$1 | numfmt --to=iec-i --suffix=B --format="%9.2f"
}

# run a bash script in the local .sh directory
bs() {
  script="$1"
  shift
  bash ".sh/${script}.sh" "$@"
}

# run a bash script in the local scripts directory
bss() {
  script="$1"
  shift
  bash "./scripts/${script}.sh" "$@"
}

# copy the karabiner goku config, wait for 1s, and tail the output
kbcp() {
  cp ~/arc/karabiner.edn ~/.config/karabiner.edn
  sleep 1
  tail /Users/adamkahn/Library/Logs/goku.log
}

# create a virtual environment
# venv() {
#   python -m venv .venv
#   source ./.venv/bin/activate
#   # create a .gitignore file if it doesn't exist
#   if [ ! -f .gitignore ]; then
#     echo ".venv\n.env" > .gitignore
#   fi
# }

# clone a github repo and cd into it
ghc() {
  gh repo clone "$@"
  repo_name=""

  # Check if $1 starts with 'http://' or 'https://'
  if [[ $1 == http://* ]] || [[ $1 == https://* ]]; then
    if [[ $1 == *".git" ]]; then
      # Extract the repo name from the URL
      repo_name=$(basename "$1" .git)
    else
      # Check if $1 contains a '/'
      if [[ $1 == */* ]]; then
        # Extract the repo name from 'username/repo'
        repo_name=$(echo "$1" | cut -d'/' -f2)
      else
        # $1 is the repo name
        repo_name=$1
      fi
    fi
  else
    # Check if $1 contains a '/'
    if [[ $1 == */* ]]; then
      # Extract the repo name from 'username/repo'
      repo_name=$(echo "$1" | cut -d'/' -f2)
    else
      # $1 is the repo name
      repo_name=$1
    fi
  fi

  # Check if $2 exists
  if [ -n "$2" ]; then
    # Use $2 as the directory name
    cd "$2" || return 1
  else
    # Use the repo name as the directory name
    if [ -n "$repo_name" ]; then
      cd "$repo_name" || return 1
    else
      return 1
    fi
  fi
}

# make a directory and cd into it
mkcd() {
  mkdir -p "$1" && cd "$1"
}

# make a git branch and cd into it
gbc() {
  git checkout -b "$1"
  cd "$1"
}

## PATH
PATH=~/.console-ninja/.bin:$PATH
PATH=~/.local/bin:$PATH

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/opt/homebrew/Caskroom/miniconda/base/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/opt/homebrew/Caskroom/miniconda/base/etc/profile.d/conda.sh" ]; then
        . "/opt/homebrew/Caskroom/miniconda/base/etc/profile.d/conda.sh"
    else
        export PATH="/opt/homebrew/Caskroom/miniconda/base/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

# The next line enables shell command completion for gcloud.
if [ -f '/Users/adamkahn/Downloads/google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/adamkahn/Downloads/google-cloud-sdk/completion.zsh.inc'; fi