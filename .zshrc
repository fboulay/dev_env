source ~/antigen.zsh

unsetopt correct_all
setopt correct

export ZSH_HIGHLIGHT_MAXLENGTH=300
export ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=20

# Load the oh-my-zsh's library.
antigen use oh-my-zsh

# Bundles from the default repo (robbyrussell's oh-my-zsh).
antigen bundle git
antigen bundle Tarrasch/zsh-bd
antigen bundle zsh-users/zsh-autosuggestions
antigen bundle command-not-found
antigen bundle djui/alias-tips
antigen bundle extract
antigen bundle tmux
antigen bundle screen
antigen bundle mvn
antigen bundle lein
antigen bundle aws
antigen bundle httpie
antigen bundle nvm
antigen bundle common-aliases
antigen bundle marzocchi/zsh-notify
antigen bundle chrissicool/zsh-256color
antigen bundle colored-man-pages
antigen bundle autojump # need to install autojump first, eg : apt install autojump

# Super history bound to ctrl+R
antigen bundle psprint/zsh-navigation-tools

# Automatically source .autoenv.zsh file in each directory, allowing to locally override any
# variable like PATH
antigen bundle Tarrasch/zsh-autoenv

# Syntax highlighting bundle (load it before history-substring-search and before zsh-directory-history)
antigen bundle zsh-users/zsh-syntax-highlighting

# History per directory (and by substring)
antigen bundle fboulay/zsh-directory-history

# bind history
zmodload zsh/terminfo
bindkey "$terminfo[kcuu1]" history-substring-search-up
bindkey "$terminfo[kcud1]" directory-history-search-forward

# Bind CTRL+k and CTRL+j to substring search
#bindkey '^j' history-substring-search-up
#bindkey '^k' history-substring-search-down

# history by substring
#antigen bundle history-substring-search

# bind UP and DOWN arrow keys to search history substring
#bindkey '^[[A' history-substring-search-up
#bindkey '^[[B' history-substring-search-down

# bind CTRL + space to accept and execute command suggestion
bindkey '^ ' autosuggest-execute

# Load the awesome theme from fboulay
antigen theme fboulay/oh-my-zsh-agnoster-fboulay agnoster-fboulay

# Tell antigen that you're done.
antigen apply

# User configuration

export EDITOR='vim'

eval "$(lesspipe)"

export MTR_OPTIONS=-t

eval $(dircolors)

# VCSH
compdef v="vcsh"
alias vd="vcsh dev_env "

# https://github.com/athityakumar/colorls
alias lc="colorls -sd"

# display last file in current directory (by date desc)
alias lf="ls -tp | grep -v /$ | head -1"
# display current date with iso 8601 format
alias now='date "+%Y-%m-%d"'

alias cam='sudo ffmpeg  -i http://192.168.1.108:4747/video -vf format=yuv420p,scale=1920x1080 -f v4l2  /dev/video2'

alias less=/usr/share/vim/vim81/macros/less.sh

alias -g C="| xclip -sel clip"
alias -g V="xclip -o"

# extract version from Maven pom.xml, use it to make a git tag, and push the tag
gtm () {
   local version=$(mvn help:evaluate -Dexpression=project.version | grep -e '^[^\[]')
   git tag -a v${version} -m "Version ${version}" && git push origin v${version}
}

# extract version from Node package.json, use it to make a git tag, and push the tag
gtn () {
  local version=$(jq -r ".version" package.json)
  git tag -a v${version} -m "Version ${version}" && git push origin v${version}
}

# create a countdown, seconds passed as the first argument - it write the countdown in a static file to be used by OBS
function count_obs() {
    date=$((`date +%s` + $1));
    date_cmd='echo -ne "$(date -u --date @$(($date - `date +%s`)) +%M:%S)"'

    while [ "$date" -ne `date +%s` ]; do
        eval $date_cmd > /tmp/count;
        sleep 1
    done
    eval $date_cmd > /tmp/count;
}

# ZSH completion
fpath=($fpath ~/.zsh/completion)
rm -f ~/.zcompdump; compinit

# NVM
[ -s $HOME/.nvm/nvm.sh ] && . $HOME/.nvm/nvm.sh # This loads NVM

# Load custom key bindings for gnome
# command to save custom key bindings
dconf load /org/gnome/desktop/wm/keybindings/ < ~/.config/dconf/user.conf

# Go language
#export GOROOT=/opt/golang
export GOPATH=~/workspace/gopath
export PATH=$PATH:$GOROOT/bin:$GOPATH/bin

# PIP
export PATH=$PATH:~/.local/bin/

# rust
export PATH="$HOME/.cargo/bin:$PATH"

# allow to read man as PDF
manps() {
  manps_file=$(mktemp manps.XXXXX)
  man -t "$1" > $manps_file
  evince $manps_file
  rm -f $manps_file
}

# yubikey agent: https://github.com/FiloSottile/yubikey-agent
export SSH_AUTH_SOCK="${XDG_RUNTIME_DIR}/yubikey-agent/yubikey-agent.sock"

source /home/fboulay/.config/broot/launcher/bash/br

# brew
eval $(/home/fboulay/.linuxbrew/bin/brew shellenv)



#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="/home/fboulay/.sdkman"
[[ -s "/home/fboulay/.sdkman/bin/sdkman-init.sh" ]] && source "/home/fboulay/.sdkman/bin/sdkman-init.sh"
