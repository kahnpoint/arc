# ARC: Adam's Run Commands

This repo holds my .bashrc (and eventually my .vimrc whenever I get around to learning vim). 
It also has some handy features like adding aliases, using a .env file at ~/.env, and installing programs.

## Setup
```
cd # go to home directory, as files should be stored in stored in ~/arc
git clone https://github.com/kahnpoint/arc
source ~/arc/.bashrc
```
You can now copy ~/arc/.bashrc to ~/.bashrc with `arccp` if you want to use it permanently (see [Arc Utilities](##arc-utilities) for other commands) 

## Commands

Arc mostly has shorthand aliases for programs (like tf=terraform), but there are a few other frequently-used aliases and functions:
- ali = add an alias to both arc/.bashrc and .bashrc (with an optional comment) and alphabetize all the aliases
  - usage: `ali 'c' 'clear' 'clear the terminal'`
- cpf = copy file contents to clipboard (WSL only)
  - usage: `cpf ~/.bashrc`
- cpc = copy command output to clipboard (WSL only)
  - usage: `cpc ls`
- mkcd = make a directory and cd into it
  - usage: `mkcd ~/newdir`
- grist = grep history (history | grep)
  - usage: `grist cd`
- bsrc = source .bashrc (source ~/.bashrc)
- .. = go down a directory (cd ..), can also do from ... to .....
- , = return to previous directory (cd -)
- (see 'MY SYNCED ALIASES' in .bashrc for more)

## Arc Utilities 
These are commands for working with Arc, and may get turned into a more formal cli tool sometime in the future.
- arc = edit /arc/.bashrc in nano and update .bashrc
- arccp = copy /arc/.bashrc to ~/.bashrc
- arcpc = copy ~/.bashrc to /arc/.bashrc
- arcup = upload /arc/.bashrc to github
- arcdn = download /arc/.bashrc from github
- arcin = install programs that have non-standard install methods (more will be added later, these are just some examples)
  - bun
  - python3.12
  - [thefuck](https://github.com/nvbn/thefuck)
    - includes WSL modifications
    - uses alias 'f' for workspace-friendliness
  
