set fish_greeting ""

set -gx TERM xterm-256color

# theme
set -g theme_color_scheme terminal-dark
set -g fish_prompt_pwd_dir_length 1
set -g theme_display_user yes
set -g theme_hide_hostname no
set -g theme_hostname always

# aliases
alias ls "ls -p -G"
alias la "ls -A"
alias ll "ls -l"
alias lla "ll -A"
alias g git
alias cp "cp -r"
alias mv "mv -i"

alias ls='exa'
alias la='exa -a'
alias ll='exa -l'
alias lal='exa -al'
alias tree='exa -T'
alias pacman='pacman --color=always'
alias nc='ncdu --color=dark --exclude-kernfs'
#create env python
function pyenv
    if test (count $argv) -ne 1
        echo "use: pyenv <name_env>"
        return
    end
    python3 -m venv $argv
    if test $status -eq 0
        echo "'$argv' is created!!!"
    else
        echo "error when creating"
    end
end

command -qv nvim && alias vim nvim

set -gx EDITOR nvim

set -gx PATH bin $PATH
set -gx PATH ~/bin $PATH
set -gx PATH ~/.local/bin $PATH
# bun
set -gx PATH ~/.bun/bin $PATH
# NodeJS
set -gx PATH node_modules/.bin $PATH

# Go
set -g GOPATH $HOME/go
set -gx PATH $GOPATH/bin $PATH

# NVM
function __check_rvm --on-variable PWD --description 'Do nvm stuff'
    status --is-command-substitution; and return

    if test -f .nvmrc; and test -r .nvmrc
        nvm use
    else
    end
end

switch (uname)
    case Darwin
        source (dirname (status --current-filename))/config-osx.fish
    case Linux
        source (dirname (status --current-filename))/config-linux.fish
    case '*'
        source (dirname (status --current-filename))/config-windows.fish
end

set LOCAL_CONFIG (dirname (status --current-filename))/config-local.fish
if test -f $LOCAL_CONFIG
    source $LOCAL_CONFIG
end

starship init fish | source
# fish_update_completions
# source ~/.config/fish/functions/fzf_key_bindings.fish
 # fish_config theme save "Catppuccin Mocha"
