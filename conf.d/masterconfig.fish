if status --is-interactive


    # not used anymore 'fisher grc' takes care of it
    #set grc_wrap_commands "cat cvs df diff dig gcc g++ ifconfig make mount mtr netstat ping ps tail traceroute wdiff"

    # colors
    #set -x LSCOLORS 'GxfxhxhxcxegedaCaCgxgx'
    #set -x CLICOLOR 1
    set -x MAVEN_COLOR true
    set -x LESS "--RAW-CONTROL-CHARS"
    set -x GREP_OPTIONS '--color=auto'
    set -x GREP_COLOR '1;33'
    set -x PATH $PATH $HOME/.krew/bin
    set -x KUBECONFIG "$HOME/.kube/config:$HOME/.kube/config.snapcore"

    # my key aliases
    alias j=z
    alias ls="lsd --group-dirs first"
    alias ll="lsd --group-dirs first -la"
    alias tree="lsd --tree --group-dirs first --depth=4"
    alias find=fd
    alias ping=prettyping
    alias ps=procs
    alias pstree="procs --tree"
    alias du="ncdu --color dark -rr -x --exclude .git --exclude node_modules"
    alias cat=bat
    alias spot=rg
    alias diff=icdiff

    alias h=helm
    alias hl="helm ls -A"
    alias k="kubectl"
    alias kd="kubectl describe"
    alias kdp="kubectl describe pod"
    alias kds="kubectl describe service"
    alias kp="kube-prompt"
    alias kg="kubectl get"
    alias kgp="kubectl get pods -o wide"
    alias kgs="kubectl get services -o wide"
    alias kgn="kubectl get nodes -o wide"
    alias kgd="kubectl get deployments -o wide"
    alias kge="kubectl get event"
    # kga --since 5m
    alias kga="kubectl get-all"
    alias kgi="kubectl get ingress -o wide"   
    alias kgna="kubectl get nodes -A -o wide"
    alias kgda="kubectl get deployments -A -o wide"
    alias kgpa="kubectl get pods -A -o wide"
    alias kgsa="kubectl get services -A -o wide"
    alias kgea="kubectl get event -A -o wide"
    alias kgia="kubectl get ingress -A -o wide"
    alias kpf="kubectl port-forward"
    alias kopen="kubectl open-svc"
    alias ktop="k9s"
    alias kcapacity="kube-capacity"
    alias kcx="kubectx"
    alias krew="kubectl krew"
    alias kns="kubens"
    alias klog="stern"
    alias kls="kubectl get-all"
    alias kwhoami="kubectl whoami"
    alias klistimages="kubectl images"
    alias kfree="kubectl view-utilization -h"
    # kshell podname /bin/sh
    alias kshell="kubectl iexec"
    alias krbac="kubectl access-matrix"

    # specific osx aliases
    if test (uname) = "Darwin"
        set -x EDITOR "subl -w"
        alias top=htop
        alias preview="open -a '$PREVIEW'"
        alias mou="open -a Typora"
    end

    # docker stuff
    alias d=docker
    alias dps="grc docker ps"
    alias dpi="grc docker images"
    alias dshell="docker run -it --rm --entrypoint /bin/sh"
    alias dtop=lazydocker
    alias dclean="docker rmi -f (docker images -f "dangling=true" -q)"
    alias dc=docker-compose

    # postgres stuff
    # alias pgstart="brew services start postgresql"
    # alias pgstop="brew services stop postgresql"
    # alias pgtop=pg_top

  #  alias minikube=/usr/local/etc/minikube-ingress-dns/minikube-ingress-dns-macos

    alias start_minikube="minikube start --vm-driver=hyperkit --memory=5120 --cpus=4 --disk-size=50g && eval (command minikube docker-env) && minikube addons enable ingress"
    alias stop_minikube="minikube stop && eval (minikube docker-env -u)"

    # fixes my typos
    alias gti=git
    alias sl=ls

    alias tfp="terraform plan | scenery"
    alias tf=terraform

    # thats the best cli prompt
    if test -x /usr/local/bin/starship
        starship init fish | source
    end

    # thats autojump
    #status --is-interactive; and source (jump shell fish | psub)

    if command -v jump >/dev/null
      status --is-interactive; and jump shell fish | source
    end

    command minikube status 1>/dev/null 2>/dev/null
    if test $status -eq 0
        eval (command minikube docker-env)
    end

    function setup_everything_for_olivier

        # install brew if not installed
        if test ! -x (which brew)
            /bin/bash -c "(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
        end

        # like autojump
        brew install jump

        # cli prompt
        brew install starship

        # ps/pstree replacement
        brew install procs

        # find replacement
        brew install fd

        # intuitive replacement for sed
        brew install sd 

        brew install mkcert
        brew install git
        brew install node
        brew install vim
        brew install fish
        brew install openssl
        brew install wget 
        brew install ffmpeg
        #brew install imagemagick
        brew install netcat 
        brew install nmap 
        brew install iftop

        brew install jq
        brew install yq 

        brew install telnet 
        brew install grc
        brew install graphviz

        brew install glow
 
        brew install nmap
        brew install mdcat
        brew install xmp
        brew install xz

        brew install htop
        #brew install pg_top

        #brew install neofetch
        # ls replacement - colored versions
        brew install lsd
        brew install rargs
        # lsd required nerd fonts
        brew tap homebrew/cask-fonts
        # don't use the -mono version, icons are off, too small
        # and don't forget to configure iTerm to use the font
        brew cask install font-meslo-nerd-font

        #brew cask install open-in-code
        brew cask install aerial
        brew cask install brooklyn
        brew cask install transmission
        brew cask install syntax-highlight
        brew cask install imageoptim
        brew cask install tinypng4mac
        brew cask install iina
        brew cask install insomnia
        brew cask install skitch
        brew cask install emby-server
        brew cask install suspicious-package

        brew install prettyping
        brew install ripgrep
        brew install ncdu
        brew install bat
        brew install icdiff

        # Kafka stuff
        # I deploy it in k8s
        # brew install kafka
        # brew install kafkacat
        # brew cask install kafka-tool

        # DB stuff -------------------------
        #brew install pgcli
        #brew install postgresql
        #brew install cockroach

        # Java stuff -------------------------
        brew install maven
        brew install ant

        # Docker stuff -------------------------
        brew install docker-ls
        brew install docker-clean

        # A tool for exploring each layer in a docker image
        # brew tap wagoodman/dive
        brew install dive

        # Load testers -----------------

        # another good one: https://github.com/fcsonline/drill
        brew install hey

        brew tap jabley/homebrew-wrk2
        brew install --HEAD wrk2

        brew install vegeta

        # Kubernates stuff ---------------------

        brew install kubernetes-cli
        brew install helm
        brew install kubectx

        # Docker-for-mac is not required anymore 
        brew install minikube
        brew install hyperkit

        # A Kubernetes cluster resource sanitizer
        brew install derailed/popeye/popeye

        # great k8s top
        brew install derailed/k9s/k9s
        # great for aggregate logging
        brew install stern
        brew install linkerd

        # shows k8s resource usage
        brew tap robscott/tap
        brew install robscott/tap/kube-capacity

        # for helmsman
        # A helm chart installer
        brew install helmsman

        helm plugin install https://github.com/futuresimple/helm-secrets
        helm plugin install https://github.com/databus23/helm-diff --version master 
        # like npm-check but for charts
        helm plugin install https://github.com/fabmation-gmbh/helm-whatup


        # Install krew pkg mgr
        brew install krew

        kubectl krew upgrade

        # https://github.com/replicatedhq/outdated
        #outdated
        kubectl krew install outdated

        # https://github.com/superbrothers/kubectl-open-svc-plugin
        #kopen
        kubectl krew install open-svc

        # https://github.com/emirozer/kubectl-doctor
        kubectl krew install doctor
        kubectl krew install oidc-login

        #kls
        kubectl krew install get-all

        # https://github.com/Ladicle/kubectl-rolesum
        kubectl krew install rolesum
        kubectl krew install access-matrix

        # https://github.com/aquasecurity/kubectl-who-can
        kubectl krew install who-can

        #kshell
        kubectl krew install iexec

        #kfree
        kubectl krew install view-utilization

        #kwhoami
        kubectl krew install whoami

        # https://github.com/chenjiandongx/kubectl-images
        kubectl krew install images

        # https://github.com/ahmetb/kubectl-tree
        kubectl krew install tree

        brew install terraform
        # terraform prettyfier/colorizer
        go get -u github.com/dmlittle/scenery

        # Setup the subl alias to SublimeText
        if not test -L /usr/local/bin/subl
               and test -f "/Applications/Sublime Text.app/Contents/SharedSupport/bin/subl"
           rm -f /usr/local/bin/subl
           ln -s "/Applications/Sublime Text.app/Contents/SharedSupport/bin/subl" /usr/local/bin/subl
        end

        npm install -g yarn
        npm install -g npm-check 
        npm install -g yarn-check
        npm install -g typescript
        npm install -g eslint
        npm install -g typesync
        npm install -g prettier
        npm install -g graphql-cli 
        npm install -g graphql-cli-get-raw-schema 
        npm install -g graphql-cli-voyager graphql-docs
        npm install -g ksuid-cli
        npm install -g hiper
        npm install -g spoof

        # deprecated for eslint
        #npm install -g tslint
        #npm install -g webpack
        #npm install -g fuge
        #npm install -g gtop
        #npm install -g pegjs
        # npm install -g graphql
        # npm install -g get-graphql-schema
        # replaced by rg
        # npm install -g spot
        # http bench
        #npm install -g ndb
        #npm install -g graphqurl
        #npm install -g lerna
        #npm install -g bolt

    end

end
