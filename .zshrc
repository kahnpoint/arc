[ -f ~/.env ] && source ~/.env 2>/dev/null

export GOKU_EDN_CONFIG_FILE="$HOME/arc/goku.edn"

# Only set zsh options if we're in zsh
[ -n "$ZSH_VERSION" ] && setopt HIST_IGNORE_ALL_DUPS 2>/dev/null

### ALIASES

## PATH
# bun and vite-node/vitest

# cargo
export PATH="$HOME/.cargo/bin:$PATH"
export PATH="/opt/homebrew/opt/rustup/bin:$PATH"
export PATH="/opt/homebrew/opt:$PATH"

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
  tail $HOME/Library/Logs/goku.log
}

# copy the aerospace config from arc repo to system
ascp() {
  cp ~/arc/aerospace.toml ~/.aerospace.toml
  echo "Aerospace config copied to ~/.aerospace.toml"
  aerospace reload-config
  echo "Aerospace config reloaded"
}

# Recursively touch file
touch_r() {
    mkdir -p "$(dirname "$1")" && touch "$1"
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

## PATH
PATH=~/.console-ninja/.bin:$PATH
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
alias alacp='sudo cp ~/arc/alacritty.toml ~/.config/alacritty/alacritty.toml' # copy arc alacritty.toml to local
alias alapc='sudo mkdir -p ~/.config/alacritty && sudo cp ~/.config/alacritty/alacritty.toml ~/arc/alacritty.toml' # copy local alacritty.toml to arc repo
alias arccp='sudo cp ~/arc/.zshrc ~/.zshrc && source ~/.zshrc' # copy arc zshrc to local
alias arcpc='sudo cp ~/.zshrc ~/arc/.zshrc && cd ~/arc' # copy local zshrc to arc repo
alias b32='bun $ARC_HOME/src/b32.ts | tee /dev/stderr | tr -d '\n' | pbcopy && echo ""'
alias b58='bun $ARC_HOME/src/b58.ts | tee /dev/stderr | tr -d '\n' | pbcopy && echo ""'
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
alias co='cursor .'
alias d='docker'
alias dc='docker compose'
alias duke='docker rm -f' # nuke a docker container
alias g='git'
alias esrc='source ~/.env' # source global .env
alias kb='karabiner'
alias kc='kubectl'
alias mk='minikube kubectl --' 
alias nr='npm run'
alias nuke='sudo rm -rf' # nuke a directory
alias nv='nvim'
alias nvcp='cp ~/arc/kickstart.nvim ~/.kickstart.nvim' # copy ~/arc/kickstart.nvim to ~/.kickstart.nvim
alias oag='openapi-generator-cli'
alias pl='pulumi'
alias plu='pulumi up -y'
alias py='python3'
alias python='python3'
alias pn='pnpm'
alias pfmt='ruff check --fix . && isort . && black .'
alias pw='bun $ARC_HOME/src/password.ts'
alias tf='terraform'
alias tfa='terraform apply -var-file=.tfvars'
alias tfd='terraform destroy -var-file=.tfvars'
alias tfi='terraform init'
alias tfp='terraform plan -var-file=.tfvars'
alias tlc='talosctl'
alias tokenize='python ~/arc/tokenizer.py'
alias u32='bun $ARC_HOME/src/u32.ts | tee /dev/stderr | tr -d '\n' | pbcopy && echo ""'
alias u64='bun $ARC_HOME/src/u64.ts | tee /dev/stderr | tr -d '\n' | pbcopy && echo ""'
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

function biff {
  if [ "$#" -lt 1 ]; then
    echo "Usage: biff <branch_name>"
    return 1
  fi
  
  # Create a subshell and redirect job control messages
  (
    # Redirect file descriptor 3 to /dev/null to suppress job control messages
    exec 3>/dev/null
    
    git fetch origin
    pids=()
    
    git diff --name-only "origin/$1" | grep '\.py$' | while read -r file; do
      if [ -f "$file" ]; then
        black "$file" &
        pids+=($!)
      fi
    done
    
    for pid in "${pids[@]}"; do
      wait "$pid"
    done
  )
}

# add, commit, and push with no checks
function gipu {
  git add .
  git commit -n -m "$1"
  git push
}

# create a new branch from the current branch
function ginb {
  git fetch origin
  git checkout "$1"
  git checkout -b "$2"
}

# force squash the current branch and push it
function gisq {
  # $1 is the target branch (e.g. main)
  # $2 is the commit message
  biff "$1"
  git add .
  git reset --soft "origin/$1"
  git commit -n -m "$2"
  git push --force-with-lease origin "$(git branch --show-current)"
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



# Source custom functions
if [ -d ~/.zsh/functions ] && [ "$(ls -A ~/.zsh/functions/*.zsh 2>/dev/null)" ]; then
  for function_file in ~/.zsh/functions/*.zsh; do
    source $function_file 2>/dev/null
  done
fi

# GIT CONFIG

# Function to set git configs safely
setup_git_config() {
  # Wait for any existing git processes to finish
  while pgrep -f "git config" > /dev/null 2>&1; do
    sleep 0.1
  done
  
  # configs
  git config pull.rebase false 2>/dev/null || true

  # checkout a branch and pull it
  git config --global alias.co 'checkout' 2>/dev/null || true
  git config --global alias.cop 'checkout -' 2>/dev/null || true

  # checkout (create branch if it doesn't exist) shortcut
  git config --global alias.cob 'checkout -b' 2>/dev/null || true

  # get hashes
  git config --global alias.hash 'rev-parse --short HEAD' 2>/dev/null || true
  git config --global alias.hashlong 'rev-parse HEAD' 2>/dev/null || true

  # aliases
  # get the 10 most recent branches
  # usage: recent 
  git config --global alias.recent "for-each-ref --count=10 --sort=-committerdate refs/heads/ --format='%(refname:short)'" 2>/dev/null || true

  # create a new branch from another branch
  # usage: from <branch_name> <new_branch_name> 
  git config --global alias.from '!sh -c "git fetch origin && git checkout \"$1\" && git checkout -b \"$2\" && git branch --set-upstream-to=origin/$1" -' 2>/dev/null || true

  # squash the current branch and push it
  # usage: squish <target_branch> <commit_message> 
  git config --global alias.squish '!sh -c "git fetch origin && git merge origin/$1 && git reset --soft \"origin/$1\" && git commit -n -m \"$2\" && git push --force-with-lease origin \"$(git branch --show-current)\"" -' 2>/dev/null || true

  # add, commit, and push with no checks
  # usage: yeet <commit_message> 
  git config --global alias.yeet '!sh -c "git add . && git commit --no-verify -m \"$1\" && git push --no-verify" -' 2>/dev/null || true

  # get the latest release branch
  # usage: latest 
  git config --global alias.latest '!git branch -r | grep "origin/release/" | sed "s/.*origin\\/release\\///" | sort -t. -k1,1n -k2,2n -k3,3n | tail -1 | xargs -I {} echo "release/{}"' 2>/dev/null || true

  # format all python files against the latest release branch
  # usage: biff 
  git config --global alias.biff '!sh -c "biff $(git latest)" -' 2>/dev/null || true
}

# Run git config setup silently in background to avoid blocking shell startup
(setup_git_config >/dev/null 2>&1 &)

# create a new git worktree and open it in cursor
function wt-new {
  if [ "$#" -lt 1 ]; then
    echo "Usage: wt-new <branch_name>"
    return 1
  fi
  
  local branch_name="$1"
  
  # Find the nearest git repo by walking up the directory tree
  local current_dir="$(pwd)"
  local git_root=""
  
  while [ "$current_dir" != "/" ]; do
    if [ -d "$current_dir/.git" ]; then
      git_root="$current_dir"
      break
    fi
    current_dir="$(dirname "$current_dir")"
  done
  
  if [ -z "$git_root" ]; then 
    echo "Error: No git repository found in current directory or any parent directory"
    return 1
  fi
  
  # Get the repository name from the git root directory
  local repo_name="$(basename "$git_root")"
  
  # Replace slashes with hyphens for the folder name
  local safe_branch_name="${branch_name//\//-}"
  
  # Create worktree directory path
  local worktree_path="$HOME/wt-$repo_name-$safe_branch_name"
  
  # Check if worktree directory already exists and move into it
  if [ -d "$worktree_path" ]; then
    echo "Worktree directory already exists: $worktree_path"
    echo "Moving into existing worktree..."
    cd "$worktree_path"
    echo "Moved into existing worktree successfully!"
    return 0
  fi
  
  # Create the directory first
  mkdir -p "$worktree_path"
  
  # Check if branch exists locally or remotely
  local branch_exists_local=$(git -C "$git_root" branch --list "$branch_name" | wc -l)
  local branch_exists_remote=$(git -C "$git_root" branch -r --list "origin/$branch_name" | wc -l)
  
  echo "Creating worktree for branch '$branch_name' in '$worktree_path'"
  
  # Try different approaches based on branch existence
  if [ "$branch_exists_local" -gt 0 ]; then
    # Branch exists locally - check if it's checked out elsewhere
    local current_branch=$(git -C "$git_root" branch --show-current)
    if [ "$current_branch" = "$branch_name" ]; then
      echo "Branch '$branch_name' is currently checked out in main repo. Creating worktree from current state..."
      # Create a new branch based on the current one for the worktree
      local temp_branch="${branch_name}-wt-$(date +%s)"
      if git -C "$git_root" worktree add -b "$temp_branch" "$worktree_path" "$branch_name"; then
        # Rename the branch in the worktree to the original name
        git -C "$worktree_path" branch -m "$temp_branch" "$branch_name"
      else
        rmdir "$worktree_path" 2>/dev/null
        echo "Error: Failed to create worktree"
        return 1
      fi
    else
      # Branch exists but not checked out, try to add it directly
      if ! git -C "$git_root" worktree add "$worktree_path" "$branch_name"; then
        rmdir "$worktree_path" 2>/dev/null
        echo "Error: Failed to create worktree"
        return 1
      fi
    fi
  elif [ "$branch_exists_remote" -gt 0 ]; then
    # Branch exists remotely, create local branch and worktree
    if ! git -C "$git_root" worktree add -b "$branch_name" "$worktree_path" "origin/$branch_name"; then
      rmdir "$worktree_path" 2>/dev/null
      echo "Error: Failed to create worktree from remote branch"
      return 1
    fi
  else
    # Branch doesn't exist, create new branch
    if ! git -C "$git_root" worktree add -b "$branch_name" "$worktree_path"; then
      rmdir "$worktree_path" 2>/dev/null
      echo "Error: Failed to create worktree with new branch"
      return 1
    fi
  fi
  
  # Move into the worktree directory
  echo "Moving into worktree..."
  cd "$worktree_path"
  
  echo "Worktree created and moved into successfully!"
}

# delete a git worktree after checking for uncommitted changes
function wt-del {
  if [ "$#" -lt 1 ]; then
    echo "Usage: wt-del <branch_name>"
    return 1
  fi
  
  local branch_name="$1"
  
  # Find the nearest git repo by walking up the directory tree
  local current_dir="$(pwd)"
  local git_root=""
  
  while [ "$current_dir" != "/" ]; do
    if [ -d "$current_dir/.git" ]; then
      git_root="$current_dir"
      break
    fi
    current_dir="$(dirname "$current_dir")"
  done
  
  if [ -z "$git_root" ]; then
    echo "Error: No git repository found in current directory or any parent directory"
    return 1
  fi
  
  # Get the repository name from the git root directory
  local repo_name="$(basename "$git_root")"
  
  # Replace slashes with hyphens for the folder name
  local safe_branch_name="${branch_name//\//-}"
  
  # Create worktree directory path
  local worktree_path="$HOME/wt-$repo_name-$safe_branch_name"
  
  # Check if worktree directory exists
  if [ ! -d "$worktree_path" ]; then
    echo "Error: Worktree directory does not exist: $worktree_path"
    return 1
  fi
  
  # Check if the worktree has any uncommitted changes
  if ! git -C "$worktree_path" diff --quiet; then
    echo "Error: Worktree has unstaged changes. Please commit or stash them first."
    return 1
  fi
  
  if ! git -C "$worktree_path" diff --cached --quiet; then
    echo "Error: Worktree has staged changes. Please commit them first."
    return 1
  fi
  
  # Check if there are any unpushed commits
  local unpushed_commits=$(git -C "$worktree_path" log --oneline @{upstream}.. 2>/dev/null | wc -l)
  if [ "$unpushed_commits" -gt 0 ]; then
    echo "Error: Worktree has $unpushed_commits unpushed commit(s). Please push them first."
    return 1
  fi
  
  # Remove the worktree
  echo "Removing worktree '$worktree_path'"
  if ! git -C "$git_root" worktree remove "$worktree_path"; then
    echo "Error: Failed to remove worktree"
    return 1
  fi
  
  echo "Worktree removed successfully!"
}

# add the homebrew lib/pkgconfig directory to the pkg-config path
export PKG_CONFIG_PATH="/usr/local/lib/pkgconfig:/opt/homebrew/lib/pkgconfig:$PKG_CONFIG_PATH"


# Only run zsh-specific commands if we're in zsh
if [ -n "$ZSH_VERSION" ]; then
  autoload -U compinit 2>/dev/null
  compinit 2>/dev/null
  # Only source jj completion if jj is available
  command -v jj >/dev/null 2>&1 && source <(jj util completion zsh) 2>/dev/null
fi