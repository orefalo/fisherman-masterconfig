if status --is-interactive

    # for matchai/spacefish
    # we switch to starfish
    #set -x SPACEFISH_KUBECONTEXT_SHOW true

    # not used anymore 'fisher grc' takes care of it
    #set grc_wrap_commands "cat cvs df diff dig gcc g++ ifconfig make mount mtr netstat ping ps tail traceroute wdiff"

    # colors
    #set -x LSCOLORS 'GxfxhxhxcxegedaCaCgxgx'
    #set -x CLICOLOR 1
    set -x MAVEN_COLOR true
    set -x LESS "--RAW-CONTROL-CHARS"
    set -x GREP_OPTIONS '--color=auto'
    set -x GREP_COLOR '1;33'
    #set -x PATH $PATH $HOME/.krew/bin

    # my key aliases
    alias j=z
    alias ls="lsd --group-dirs first"
    alias ll="lsd --group-dirs first -l"
    alias ll="lsd --group-dirs first -a"
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
    alias hl="helm list --all-namespaces"

    alias k=kubectl
    alias kd="kubectl describe"
    alias kdp="kubectl describe pod"
    alias kds="kubectl describe service"
    alias kp="kube-prompt"
    alias kg="kubectl get"
    alias kgp="kubectl get pods"
    alias kgs="kubectl get services"
    alias kgn="kubectl get nodes"
    alias kge="kubectl get event -A"
    alias kgi="kubectl get ingress"   
    alias kpf="kubectl port-forward"
    alias ktop="k9s"
    alias kcapacity="kube-capacity"
    alias kgn="kubectl get nodes --label-columns failure-domain.beta.kubernetes.io/region,failure-domain.beta.kubernetes.io/zone"
    alias kcx=kubectx
    alias krew="kubectl krew"
    alias kns=kubens
    alias klog=stern
    alias kshell="kubectl exec -it $1 -- /bin/sh"

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
    alias pgstart="brew services start postgresql"
    alias pgstop="brew services stop postgresql"
    alias pgtop=pg_top

    alias minikube=/usr/local/etc/minikube-ingress-dns/minikube-ingress-dns-macos

    alias start_minikube="minikube start --vm-driver=hyperkit --memory=6144 --cpus=4 --disk-size=50g && eval (command minikube docker-env) && minikube addons enable ingress"
    alias stop_minikube="minikube stop && eval (minikube docker-env -u)"

    # fixes my typos
    alias gti=git
    alias sl=ls

    alias tfp="terraform plan | scenery"
    alias tf=terraform



    if test -x /usr/local/bin/starship
        starship init fish | source
    end

    # for now needs to be manually installed from https://github.com/euank/pazi
    if test -x /usr/local/bin/pazi
        pazi init fish | source
    end

    command minikube status 1>/dev/null 2>/dev/null
    if test $status -eq 0
            eval (command minikube docker-env)
    end


    function setup_everything_for_olivier

        # install brew if not installed
        if test ! -x (which brew)
            /usr/bin/ruby -e "(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
        end

        brew install https://raw.githubusercontent.com/orefalo/homebrew-core/pazi/Formula/pazi.rb

        # cli prompt
        brew install starship

        # ps replacement
        brew install procs

        # find replacement
        brew install fd

        # replacement for j or z
        #brew install fasd
        brew install mkcert
        brew install git
        brew install node
        brew install vim
        #brew install grafana
        #brew install influxdb
        brew install fish
        brew install openssl
        brew install wget 
        #brew install tig 
        brew install ffmpeg
        brew install imagemagick
        #brew install denisidoro/tools/navi
        brew install netcat 
        brew install nmap 
        brew install iftop
        # procs --tree 
        #brew install pstree 
        brew install jq
        brew install yq 
        # lsd --tree comes with icons and coloring
        # brew install tree 
        brew install telnet 
        brew install grc
        brew install graphviz
        #brew install inav
        brew install nmap
        brew install mdcat
        brew install vegeta
        brew install xmp
        brew install xz

        brew install htop
        brew install ctop
        #brew install ktop
        brew install pg_top

        brew install neofetch
        # colored versions
        # lsd seems better
        #brew install acarl005/homebrew-formulas/ls-go
        brew install lsd
        # lsd required nerd fonts
        brew tap homebrew/cask-fonts
        # don't use the -mono version, icons are off, too small
        # and don't forget to configure iTerm to use the font
        brew cask install font-meslo-nerd-font

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
        # get htop for docker
        brew install lazydocker

        # Kubernates stuff ---------------------
        brew install kubernetes-cli
        brew install kubernetes-helm
        brew install kubectx
        # OIC login to k8s
        brew install int128/kubelogin/kubelogin
        # Docker-for-mac is not required anymore 
        brew install minikube
        brew install hyperkit
        # Install krew
        brew install krew

        # ---
        brew tap superbrothers/minikube-ingress-dns git://github.com/superbrothers/minikube-ingress-dns.git
        brew install minikube-ingress-dns
        brew install dnsmasq
        # ----

        # A Kubernetes cluster resource sanitizer
        brew install derailed/popeye/popeye
        # great k8s top
        brew install derailed/k9s/k9s
        # great for aggregate logging
        brew install stern
        brew install linkerd

        brew tap robscott/tap
        brew install robscott/tap/kube-capacity
        brew install kube-prompt
        # need some chmod +s here
        
        # A tool for exploring each layer in a docker image
        brew tap wagoodman/dive
        brew install dive

        # Best load tester
        # I prefer hey
        #brew tap loadimpact/k6
        #brew install k6
        brew install hey wrk2


        brew install terraform
        #brew install terragrunt

        brew cask install open-in-code
        brew cask install kubernetic
        brew cask install aerial
        brew cask install iina
        # broken with catalina
        # brew cask install qlcolorcode # Preview source code files with syntax highlighting
        # brew cask install qlstephen # Preview plain text files without a file extension. Example: README, CHANGELOG, etc.
        # brew cask install qlmarkdown # Preview Markdown files
        # brew cask install quicklook-json # Preview JSON files
        # brew cask install qlprettypatch # Preview .patch files
        # brew cask install quicklook-csv # Preview CSV files
        # brew cask install qlimagesize # Display image size and resolution
        # brew cask install webpquicklook # Preview WebP images
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
        npm install -g prettier
        npm install -g graphql
        npm install -g graphql-cli 
        npm install -g graphql-cli-get-raw-schema 
        npm install -g graphql-cli-voyager graphql-docs
        npm install -g get-graphql-schema
        npm install -g ksuid-cli
        # replaced by rg
        # npm install -g spot

        # http bench
        npm install -g hiper
        npm install -g spoof
        npm install -g ndb
        npm install -g graphqurl
        npm install -g lerna
        

        kubectl krew update

        # https://github.com/superbrothers/kubectl-open-svc-plugin
        kubectl krew install open-svc
        kubectl krew install doctor
        kubectl krew install oidc-login
        kubectl krew install cssh

        # terraform prettyfier/colorizer
        go get -u github.com/dmlittle/scenery


        # Setup the subl alias to SublimeText
        if not test -L /usr/local/bin/subl
               and test -f "/Applications/Sublime Text.app/Contents/SharedSupport/bin/subl"
           rm -f /usr/local/bin/subl
           ln -s "/Applications/Sublime Text.app/Contents/SharedSupport/bin/subl" /usr/local/bin/subl
        end

    end

end
