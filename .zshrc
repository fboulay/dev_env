source ~/antigen.zsh

unsetopt correct_all
setopt correct

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
antigen bundle zsh_reload

# Super history bound to ctrl+R
antigen bundle psprint/zsh-navigation-tools

# Automatically source .autoenv.zsh file in each directory, allowing to locally override any
# variable like PATH
antigen-bundle Tarrasch/zsh-autoenv

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

# ZSH aliases
fpath=($fpath ~/.zsh/completion)

# NVM
[ -s $HOME/.nvm/nvm.sh ] && . $HOME/.nvm/nvm.sh # This loads NVM

# Go language
export GOROOT=/opt/golang
export GOPATH=~/workspace/gopath
export PATH=$PATH:$GOROOT/bin:$GOPATH/bin

# PIP
export PATH=$PATH:~/.local/bin/
