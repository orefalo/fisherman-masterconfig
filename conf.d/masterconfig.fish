if status --is-interactive

    # for matchai/spacefish
    set -x SPACEFISH_KUBECONTEXT_SHOW false

    # not used anymore 'fisher grc' takes care of it
    #set grc_wrap_commands "cat cvs df diff dig gcc g++ ifconfig make mount mtr netstat ping ps tail traceroute wdiff"

    # colors
    set -x LSCOLORS 'GxfxhxhxcxegedaCaCgxgx'
    set -x CLICOLOR 1
    set -x MAVEN_COLOR true
    set -x LESS "--RAW-CONTROL-CHARS"
    set -x GREP_OPTIONS '--color=auto'
    set -x GREP_COLOR '1;33'

    # my key aliases
    alias j=z
    alias ll="ls-go -l"
    alias ls="ls-go"
    alias ping=prettyping
    alias du="ncdu --color dark -rr -x --exclude .git --exclude node_modules"
    alias cat=bat
    alias spot=rg
    alias diff=icdiff

    # specific osx aliases
    if test (uname) = "Darwin"
        set -x EDITOR "subl -w"
        alias top=htop
        alias preview="open -a '$PREVIEW'"
        alias mou="open -a MacDown"
        alias jd="open -a JD-GUI"
    end

    # docker stuff
    alias dps="grc docker ps"
    alias dpi="grc docker images"
    alias dshell="docker run -it --rm --entrypoint /bin/sh"
    alias dc=docker-compose

    # postgres stuff
    alias pgstart="brew services start postgresql"
    alias pgstop="brew services stop postgresql"
    alias pgtop=pg_top

    # fixes my typos
    alias gti=git
    alias sl=ls

    alias tfp="terraform plan | scenery"
    alias tf=terraform

    function setup_everything_for_olivier

        #if test ! -x (which brew)
            # install brew if not installed
        #    /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
        #end

        brew install fasd
        brew install mkcert
        brew install git
        #brew install node@8
        brew install node
        brew install vim
        brew install grafana
        brew install influxdb
        brew install fish
        brew install openssl
        brew install wget 
        brew install tig 
        brew install ffmpeg
        brew install imagemagick
        brew install denisidoro/tools/navi
        brew install netcat 
        brew install nmap 
        brew install iftop 
        brew install pstree 
        brew install jq 
        brew install tree 
        brew install telnet 
        brew install grc
        brew install graphviz
        brew install inav
        brew install jq
        brew install nmap
        brew install mdcat
        brew install vegeta
        brew install xmp
        brew install xz

        brew install htop
        brew install ctop
        brew install ktop
        brew install pg_top

        # colored versions
        brew install acarl005/homebrew-formulas/ls-go
        brew install prettyping
        #brew install ranger
        brew install ripgrep
        brew install ncdu
        brew install bat
        brew install icdiff

        # Kafka stuff
        brew install kafka
        brew install kafkacat
        brew cask install kafka-tool

        # DB stuff
        brew install pgcli
        #brew install postgresql
        #brew install cockroach

        # Java stuff
        brew install maven
        brew install ant

        # Docker stuff
        brew install docker-ls
        brew install docker-clean

        # Kubernates stuff
        #brew cask install minikube
        brew install kubernetes-cli
        brew install kubernetes-helm
        brew install kubectx
     
        brew install stern
        brew install linkerd
        # need some chmod +s here
        
        # A tool for exploring each layer in a docker image
        brew tap wagoodman/dive
        brew install dive

        # Best load tester
        brew tap loadimpact/k6
        brew install k6

        brew install terraform
        #brew install terragrunt

        brew cask install kubernetic
        brew cask install aerial
        brew cask install iina
        brew cask install qlcolorcode # Preview source code files with syntax highlighting
        brew cask install qlstephen # Preview plain text files without a file extension. Example: README, CHANGELOG, etc.
        brew cask install qlmarkdown # Preview Markdown files
        brew cask install quicklook-json # Preview JSON files
        brew cask install qlprettypatch # Preview .patch files
        brew cask install quicklook-csv # Preview CSV files
        brew cask install qlimagesize # Display image size and resolution
        brew cask install webpquicklook # Preview WebP images
        brew cask install suspicious-package # Preview the contents of a standard Apple installer package

        #if test ! -x (which fisher)
            # install fisher if not installed
        #    curl -Lo ~/.config/fish/functions/fisher.fish --create-dirs https://git.io/fisher
        #end

        npm install -g yarn
        npm install -g npm-check 
        npm install -g yarn-check
        npm install -g typescript
        npm install -g tslint
        npm install -g eslint
        npm install -g typesync
        npm install -g webpack
        npm install -g fuge
        npm install -g gtop
        npm install -g pegjs
        #npm install -g prisma
        npm install -g prettier
        npm install -g graphql
        npm install -g graphql-cli 
        npm install -g graphql-cli-get-raw-schema 
        npm install -g graphql-cli-voyager graphql-docs
        npm install -g get-graphql-schema
        npm install -g hiper
        npm install -g ksuid-cli
        # replaced by rg
        # npm install -g spot
        npm install -g spoof
        npm install -g git-commander
        #npm install -g ndb
        npm install -g graphqurl

        go get -u github.com/dmlittle/scenery

    end

    # Setup the subl alias to SublimeText
    if not test -L /usr/local/bin/subl
           and test -f "/Applications/Sublime Text.app/Contents/SharedSupport/bin/subl"
       rm -f /usr/local/bin/subl
       ln -s "/Applications/Sublime Text.app/Contents/SharedSupport/bin/subl" /usr/local/bin/subl
    end



end

