if status --is-interactive

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
    alias ll="ls -lh"
    alias ls="ls -color"

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

    function setup_everything_for_olivier

        #if test ! -x (which brew)
            # install brew if not installed
        #    /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
        #end

        brew install git ant maven node@8 arc vim
        brew install grafana influxdb fish openssl wget kafka htop tig ffmpeg
        brew install pgcli postgresql  pg_top kafkacat imagemagick kafkacat netcat nmap 
        brew install cockroach iftop pstree jq tree telnet docker-clean
        brew install docker-ls grc
        brew install graphviz node ncdu inav
        brew install stop jq nmap
        brew install xmp maven xz
        brew install kubernetes-cli kubernetes-helm

        brew cask install minikube
        brew cask install aerial
        brew cask install iina
        brew cask install kafka-tool
        brew cask install qlcolorcode # Preview source code files with syntax highlighting
        brew cask install qlstephen # Preview plain text files without a file extension. Example: README, CHANGELOG, etc.
        brew cask install qlmarkdown # Preview Markdown files
        brew cask install quicklook-json # Preview JSON files
        brew cask install qlprettypatch # Preview .patch files
        brew cask install quicklook-csv # Preview CSV files
        brew cask install betterzipql # Preview archives
        brew cask install qlimagesize # Display image size and resolution
        brew cask install webpquicklook # Preview WebP images
        brew cask install suspicious-package # Preview the contents of a standard Apple installer package

        brew tap loadimpact/k6
        brew install k6

        #if test ! -x (which fisher)
            # install fisher if not installed
        #    curl -Lo ~/.config/fish/functions/fisher.fish --create-dirs https://git.io/fisher
        #end

        npm install -g yarn npm-check yarn-check
        npm install -g typescript tslint eslint
        npm install -g typesync webpack
        npm install -g fuge gtop pegjs
        npm install -g spot prisma prettier
        npm install -g graphql graphql-cli graphql-cli-get-raw-schema graphql-cli-voyager graphql-docs get-graphql-schema
        npm install -g hiper ksuid-cli spot
        npm install -g spoof
        npm install -g git-commander

    end


    # specific osx aliases
    if test (uname) = "Darwin"
        set -x EDITOR "subl -w"
        alias top=htop
        alias preview="open -a '$PREVIEW'"
        alias mou="open -a MacDown"
        alias jd="open -a JD-GUI"
    end

    # Setup the subl alias to SublimeText
    if not test -L /usr/local/bin/subl
           and test -f "/Applications/Sublime Text.app/Contents/SharedSupport/bin/subl"
       rm -f /usr/local/bin/subl
       ln -s "/Applications/Sublime Text.app/Contents/SharedSupport/bin/subl" /usr/local/bin/subl
    end

end

