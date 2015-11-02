#!/usr/local/bin/zsh

platform='unknown'
unamestr=$(uname)
if [[ "$unamestr" == 'Darwin' ]]; then
   platform='macos'
elif [[ "$unamestr" == 'Linux' ]]; then
   platform='linux'
fi

export ZSH=$HOME/.oh-my-zsh
export LANG=en_US.UTF-8
export DISABLE_AUTO_UPDATE="true"
export ZSH_THEME="robbyrussell"
export EDITOR='nvim'
#export NVIM_TUI_ENABLE_CURSOR_SHAPE=1
#export NVIM_TUI_ENABLE_TRUE_COLOR=1
export SHELL='zsh'
export LC_CTYPE=en_US.UTF-8
export LC_ALL=en_US.UTF-8
export NNTPSERVER='news.tweaknews.eu'
export MUTT_EMAIL_ADDRESS="jakesjews@gmail.com"
export MUTT_REALNAME="Jacob Jewell"
export MUTT_SMTP_URL="smtp://jakesjews@smtp.gmail.com:587/"
export DISABLE_AUTO_TITLE=true
export TERM=xterm-256color
export ANSIBLE_HOST_KEY_CHECKING=False
export KEYTIMEOUT=1
export LISTMAX=9998

if [[ $platform == 'macos' ]]; then
    export VAGRANT_DEFAULT_PROVIDER='vmware_fusion'
    source ~/.homebrew.token

    export NEOVIM_LISTEN_ADDRESS=/tmp/neovim.sock
    export JAVA_HOME=$(/usr/libexec/java_home -v 1.8)
    export HIVE_HOME=/usr/local/Cellar/hive/0.10.0/libexec
    export GROOVY_HOME=/usr/local/Cellar/groovy/2.0.5/libexec
    export GOPATH=/usr/local/lib/go
    export VOLDEMORT_HOME='/usr/local/Cellar/voldemort/0.90.1/libexec'
    export LIQUIBASE_HOME="/usr/local/Cellar/liquibase/3.1.1/libexec"
    export JBOSS_HOME=/usr/local/opt/wildfly-as/libexec

    export ANDROID_HOME=/usr/local/opt/android-sdk
    #export POSTGRES_ROOT=/Applications/Postgres.app/Contents/Versions/9.4/bin
    export CLOJURE_ROOT=/Users/jacob/.cljr/bin
    export CABAL_ROOT=/Users/jacob/.cabal/bin
    export TEX_ROOT=/usr/textbin
    export LATEX_ROOT=/usr/local/texlive/2014/bin/x86_64-darwin
    export CUDA_ROOT=/Developer/NVIDIA/CUDA-5.5/bin
    export VMWARE_ROOT="/Applications/VMware Fusion.app/Contents/Library"
    export HEROKU_ROOT=/usr/local/heroku/bin
    export NPM_ROOT=/usr/local/share/npm/bin
    export GO_ROOT=$GOPATH/bin
    export JBOSS_ROOT=$JBOSS_HOME/bin
    export EMSCRIPTEN_ROOT="/Users/jacob/dev/sdk/emscripten/emscripten/1.13.0"
    export HAXE_STD_PATH="/usr/local/lib/haxe/std"
    export BREW_ROOT=/usr/local/bin:/usr/local/sbin

    # python
    #export WORKON_HOME=$HOME/.virtualenvs
    #export VIRTUALENVWRAPPER_PYTHON=/usr/bin/python2.7
    #export VIRTUALENVWRAPPER_VIRTUALENV_ARGS='--no-site-packages'
    #export PIP_VIRTUALENV_BASE=$WORKON_HOME
    #export PIP_RESPECT_VIRTUALENV=true

    export PKG_CONFIG_PATH=$PKG_CONFIG_PATH:/Library/Frameworks/Mono.framework/Versions/Current/lib/pkgconfig

    export NODE_PATH=/usr/local/lib/node_modules
    export COFFEELINT_CONFIG=/Users/jacob/.coffeelintrc
    export JAVA_MAN=/Library/Java/JavaVirtualMachines/jdk1.8.0_45.jdk/Contents/Home/man
    export ERLANG_MAN=/usr/local/opt/erlang/lib/erlang/man

    export MANPATH=$JAVA_MAN:$MANPATH:$ERLANG_MAN

    export PATH=/bin:/sbin:$CABAL_ROOT:$BREW_ROOT:$CLOJURE_ROOT:$LATEX_ROOT:$HEROKU_ROOT:$VMWARE_ROOT:$GO_ROOT:$PATH:$NPM_ROOT:$TEX_ROOT:$CUDA_ROOT:$JBOSS_ROOT:$EMSCRIPTEN_ROOT:$JAVA_HOME/bin
else
    export PATH=$PATH
fi

plugins=(vi-mode gitfast cake gem lein mvn node npm redis-cli github heroku mercurial pip vagrant coffee golang bower scala rebar colorize zsh-syntax-highlighting cabal cpanm sbt mix tmux tmuxinator rbenv pod autojump colored-man docker rsync extract encode64 history-substring-search copyfile colorize zsh_reload jsontools grunt adb coffee docker-compose terraform ember-cli colored-man-pages)

plugins+=(cabal-upgrade functional)

if [[ $platform == 'macos' ]]; then
    plugins+=(brew osx)
else
    plugins+=(debian command-not-found)
fi

autoload zargs
autoload zmv

zmodload zsh/datetime
zmodload zsh/stat
zmodload zsh/files
zmodload zsh/mapfile
zmodload zsh/mathfunc
zmodload zsh/net/socket
zmodload zsh/zftp
zmodload zsh/attr
zmodload zsh/net/tcp

unsetopt listambiguous

source "$ZSH/oh-my-zsh.sh"
bindkey '\e[A' history-substring-search-up
bindkey '\e[B' history-substring-search-down

if [[ $platform == 'macos' ]]; then
    alias vim='shell=bash nvim'
    alias 9="/usr/local/bin/9"
    alias profile-mono="LD_LIBRARY_PATH=/Library/Frameworks/Mono.framework/Versions/Current/lib MONO_OPTIONS=--profile=log:noalloc xsp"
    alias jconsole="/Applications/j64-802/bin/jconsole"
    alias postgres="postgres -D /usr/local/var/postgres"
    alias Factor="/Applications/factor/factor"
fi

alias space="du -d 1 -h | sort -n"
alias fuck='eval $(thefuck $(fc -ln -1 | tail -n 1)); fc -R'
alias ag='ag -i'
alias dockersetup='eval "$(docker-machine env dev)"'
alias l="ls"
alias immersiveapps='ssh immersiveapplications.com'
alias mmv="noglob zmv -W"
alias xsp="xsp4 --port 8080"
alias ssh-tunnel="ssh -D 8080 -C -N immersiveapplications.com"
alias ms='mocha --fgrep "#slow" -i'
alias findproc="pgrep -ifL"
alias sl="ls"
alias mocha="mocha --bail"
alias npmo="npm outdated"
alias orig="rm **/*.orig"

# OPAM configuration
. /Users/jacob/.opam/opam-init/init.zsh > /dev/null 2> /dev/null || true

source ~/.xsh

function mcd() { mkdir "$1" && cd "$1"; }

function enable-mono-tools() { 
    export DYLD_FALLBACK_LIBRARY_PATH=/lib:/usr/lib:/usr/local/lib:/Library/Frameworks/Mono.framework/Versions/Current/lib
}

function clean-eflex() {
    tmux kill-server
    sudo pkill proftpd
}

function restart-eflex() {
    clean-eflex
    mux eflex
}

function update-servers() {
    ansible all -m "apt" -a "upgrade=dist update_cache=true" -s
}

function code () {
    if [[ $# = 0 ]]
    then
        open -a "Visual Studio Code"
    else
        [[ $1 = /* ]] && F="$1" || F="$PWD/${1#./}"
        open -a "Visual Studio Code" --args "$F"
    fi
}

function update-git-bzr() {
    wget https://raw.github.com/felipec/git-remote-bzr/master/git-remote-bzr -O /usr/local/opt/git/bin/git-remote-bzr && \
    chmod +x /usr/local/opt/git/bin/git-remote-bzr && \
    rm /usr/local/bin/git-remote-bzr 2>/dev/null && \
    ln -s /usr/local/opt/git/bin/git-remote-bzr /usr/local/bin/git-remote-bzr && \
    vim /usr/local/opt/git/bin/git-remote-bzr
}

function update() {
    setopt localoptions rmstarsilent

    brew update
    brew upgrade --all
    brew cleanup -s
    brew prune
    brew tap --repair
    rm -rf /Library/Caches/Homebrew/*

    vim +PlugUpdate +PlugUpgrade +qa

    npm cache clean
    npm update -g
     
    gem update

    julia -e "Pkg.update()"

    expect -c "
        set timeout -1
        spawn gem cleanup
        set done 0

        while {\$done == 0} {
            expect {
                \"Continue with Uninstall\\\\\\? \\\\\\[Yn\\\\\\]\" { send \"n\r\" }
                \"Clean Up Complete\" { set done 1 }
            }
        }
        wait
        close $spawn_id
    "

    meteor update

    vagrant plugin update

    cd /Users/jacob/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting && git pull
}

eval "$(rbenv init -)"


