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

export JAVA_HOME=/usr/lib/jvm/java-8-oracle

export PATH="/home/fboulay/.nvm/v0.10.28/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/opt/play:/opt/maven/bin:/opt/cloudbees:/opt/ant/bin:/var/lib/gems/1.8/bin://opt/scala/bin:/opt/android-sdk-linux/tools:/opt/android-sdk-linux/platform-tools:/opt/vert.x/bin:/home/fboulay/bin:/opt/hadoop/bin:/opt/gce/google-cloud-sdk/bin/:/opt/pig/bin"

export EDITOR='vim'

alias parquettools='java -jar ~/workspace/parquet-mr/parquet-tools/target/parquet-tools-1.8.1.jar '

eval "$(lesspipe)"

export MTR_OPTIONS=-t 

eval $(dircolors)

compdef v="vcsh"
alias vd="vcsh dev_env " 

fpath=($fpath ~/.zsh/completion)

export NVM_DIR="/home/florian/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm
