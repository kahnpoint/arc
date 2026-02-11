[ -f ~/.env ] && source ~/.env 2>/dev/null

export COLORTERM=truecolor

# Sync iTerm2 config to arc repo (runs silently on shell load)
if [ -d "$HOME/arc/config" ] && [ -f "$HOME/Library/Preferences/com.googlecode.iterm2.plist" ]; then
  plutil -convert json -o "$HOME/arc/config/iterm2.json" "$HOME/Library/Preferences/com.googlecode.iterm2.plist" 2>/dev/null
fi

export GOKU_EDN_CONFIG_FILE="$HOME/arc/config/karabiner.edn"

# Only set zsh options if we're in zsh
[ -n "$ZSH_VERSION" ] && setopt HIST_IGNORE_ALL_DUPS 2>/dev/null

### ALIASES

## PATH
export PATH="$HOME/.cargo/bin:$PATH"
export PATH="$HOME/go/bin:$PATH"
export PATH="/opt/homebrew/opt/rustup/bin:$PATH"
export PATH="/opt/homebrew/opt:$PATH"


# add the homebrew lib/pkgconfig directory to the pkg-config path
export PKG_CONFIG_PATH="/usr/local/lib/pkgconfig:/opt/homebrew/lib/pkgconfig:$PKG_CONFIG_PATH"
export PATH="/opt/homebrew/opt/ruby/bin:$PATH"


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

# reload aerospace config (symlinked)
asr() {
  aerospace reload-config
  echo "Aerospace config reloaded"
}

# Recursively touch file
touch_r() {
    mkdir -p "$(dirname "$1")" && touch "$1"
}

# watch a cargo binary
# usage: crb <binary_name>
function crb {
  cargo watch -c -q -x "run --bin $1"
}

# watch a cargo test
# usage: ctw <test_name>
function ctw {
  cargo watch -c -q -x "test $1 -- --nocapture"
}

# clone a github repo and cd into it
ghc() {
  if ! command -v gh >/dev/null 2>&1; then
    echo "Error: GitHub CLI (gh) is not installed"
    return 1
  fi
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

# claude code latest plans - show 5 most recently edited plans
cllp() {
  (cd ~/.claude/plans && ls -t *.md 2>/dev/null | head -15 | xargs -I{} stat -f "%Sm  {}" -t "%Y-%m-%d %H:%M:%S" {})
}

## PATH

PATH=~/.local/bin:$PATH
export CONDA_AUTO_ACTIVATE_BASE=false
# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
export CONDA_AUTO_ACTIVATE_BASE=false
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

# Reset conda shell level to ensure clean state
export CONDA_SHLVL=0

# The next line enables shell command completion for gcloud.
if [ -f '$HOME/Downloads/google-cloud-sdk/completion.zsh.inc' ]; then . '$HOME/Downloads/google-cloud-sdk/completion.zsh.inc' 2>/dev/null; fi
# pnpm
export PNPM_HOME="$HOME/Library/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end

export NODE_NO_WARNINGS=1


export NVM_DIR="$HOME/.nvm"
[ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"  # This loads nvm
[ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion
export PATH="/opt/homebrew/opt/openjdk/bin:$PATH"
export PATH=$HOME/.nvm/versions/node/v21.7.3/bin:$PATH

### ALIASES

# MY SYNCED ALIASES - START
alias .env='sudo nano ~/.env'
alias .....='cd ../../../../'
alias ....='cd ../../../'
alias ...='cd ../../'
alias ..='cd ..'
alias b32='bun $ARC_HOME/scripts/ts/b32.ts | tee /dev/stderr | tr -d '\n' | pbcopy && echo ""'
alias b58='bun $ARC_HOME/scripts/ts/b58.ts | tee /dev/stderr | tr -d '\n' | pbcopy && echo ""'
alias b='bun'
alias ba='bun add'
alias bf='bun run fmt'
alias bi='bun install'
alias big='bun install --global'
alias br='bun run'
alias brw='bun run --watch'
alias btw='bun test --watch'
alias bx='bunx'
alias c='clear'
alias cg='cargo'
alias cga='cargo add'
alias cgf='cargo fmt'
alias cgi='cargo install'
alias cgr="cargo watch -c -x 'run  -- --nocapture'"
alias cgt="cargo watch -c -x 'test -- --nocapture'"
alias cgw='cargo watch -c'
alias co='code .'
alias d='docker'
alias dc='docker compose'
alias duke='docker rm -f' # nuke a docker container
alias g='git'
alias esrc='source ~/.env' # source global .env
alias id32='bun $ARC_HOME/scripts/ts/id32.ts | tee /dev/stderr | tr -d '\n' | pbcopy && echo ""'
alias kb='karabiner'
alias kc='kubectl'
alias mk='minikube kubectl --' 
alias nr='npm run'
alias nuke='sudo rm -rf' # nuke a directory
alias nv='nvim'
alias oag='openapi-generator-cli'
alias ob='open -a Obsidian .'
alias pl='pulumi'
alias plu='pulumi up -y'
alias py='python3'
alias python='python3'
alias pn='pnpm'
alias pfmt='ruff check --fix . && isort . && black .'
alias pw='bun $ARC_HOME/scripts/ts/password.ts'
alias tf='terraform'
alias tfa='terraform apply -var-file=.tfvars'
alias tfd='terraform destroy -var-file=.tfvars'
alias tfi='terraform init'
alias tfp='terraform plan -var-file=.tfvars'
alias tlc='talosctl'
alias tokenize='python ~/arc/tokenizer.py'
alias u32='bun $ARC_HOME/scripts/ts/u32.ts | tee /dev/stderr | tr -d '\n' | pbcopy && echo ""'
alias u64='bun $ARC_HOME/scripts/ts/u64.ts | tee /dev/stderr | tr -d '\n' | pbcopy && echo ""'
alias uuid="uuidgen | tee /dev/stderr | tr -d '\n' | pbcopy"
alias vn='vite-node'
alias vnw='vite-node --watch'
alias vsrc='source .venv/bin/activate'
alias vt='vitest'
alias vtw='vitest --watch'
alias wr='wrangler'
alias zsrc='source ~/.zshrc' # source zshrc
alias npr='npm run'
# MY SYNCED ALIASES - END

# Claude Code
cl() { caffeinate -dims claude --dangerously-skip-permissions "$@"; }
clc() { caffeinate -dims claude --chrome --dangerously-skip-permissions "$@"; }

# OpenCode
oc() { caffeinate -dims opencode "$@"; }
oco() { caffeinate -dims opencode --model "openai/gpt-5.3-codex" "$@"; }
ocz() { caffeinate -dims opencode --model "zai-coding-plan/glm-4.7" "$@"; }
ock() { caffeinate -dims opencode --model "kimi-for-coding/k2p5" "$@"; }

export PATH="/opt/homebrew/opt/libpq/bin:$PATH"
export DISABLE_AUTOUPDATER=1

# qlty
export QLTY_INSTALL="$HOME/.qlty"
export PATH="$QLTY_INSTALL/bin:$PATH"

export NODE_OPTIONS="--max-old-space-size=20480"

# opencode
export PATH=/Users/adam/.opencode/bin:$PATH
