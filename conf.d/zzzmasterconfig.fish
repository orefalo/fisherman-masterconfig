if status --is-interactive
    # not used anymore 'fisher grc' takes care of it
    #set grc_wrap_commands "cat cvs df diff dig gcc g++ ifconfig make mount mtr netstat ping ps tail traceroute wdiff"

    # colors

    theme_tokyonight night

    #set -x LSCOLORS 'GxfxhxhxcxegedaCaCgxgx'
    #set -x CLICOLOR 1
    set -x MAVEN_COLOR true
    set -x LESS "--RAW-CONTROL-CHARS"
    set -x GREP_OPTIONS '--color=auto'
    set -x GREP_COLOR '1;33'
    fish_add_path --path $HOME/.krew/bin
    set -x KUBECONFIG "$HOME/.kube/config:$HOME/.kube/config.snapcore"
    set -x SAM_CLI_TELEMETRY 0
    set -x HOMEBREW_NO_ANALYTICS 1

    # my key aliases
    alias ..='cd ..'
    alias ...='cd ../..'
    alias j=z
    alias ls="lsd --group-dirs first"
    alias ll="lsd --group-dirs first -la"
    alias l='ls -l'
    alias lt='ls --tree --depth=3'
    alias sl=ls
    alias dig=dog
    # broot bellow is a better tree alternative
    #alias tree="lsd --tree --group-dirs first --depth=4"
    alias tree="broot"
    alias find=fd
    alias ping=prettyping
    # I don't like procs for this use case
    # alias ps=procs
    # alias pstree="procs --tree"
    alias du=duf
    alias duf=dust
    alias cat='bat --style=header,grid'
    alias more=cat
    alias mroe=cat
    alias spot=rg
    alias diff=difftastic
    alias httpie=xh
    alias publicip='curl ifconfig.me'
    #alias cp='rsync --progress -avz --ignore-existing'
    alias update='brew update;brew upgrade;brew autoremove;brew cleanup; pnpm update -g'
    alias cleanup="command find . -type f -name '*.DS_Store' -ls -delete"

    alias unalias="functions -e "

    alias h=helm
    alias hl="helm ls -A"
    alias k="kubectl"
    alias kd="kubectl describe"
    alias kdp="kubectl describe pod"
    alias kds="kubectl describe service"
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
    alias kfree="kubectl view-utilization -h"
    alias kcapacity="kube-capacity"
    alias kctx="kubectx"
    alias krew="kubectl krew"
    alias kns="kubens"
    alias klog="stern"
    alias kls="kubectl get-all"
    alias kwhoami="kubectl whoami"
    alias klistimages="kubectl images"
    alias klistapis="kubectl api-resources -o wide"
    alias kupdate="k outdated"

    # kshell podname /bin/sh
    alias kshell="kubectl iexec"
    alias krbac="kubectl access-matrix"

    # specific osx aliases
    if test (uname) = "Darwin"
        set -x EDITOR "subl -w"
        alias top=zenith
        alias diff=difftastic
        alias preview="open -a '$PREVIEW'"
        alias mou="open -a Typora"
    end

    # docker stuff
    alias d=docker
    alias dc=docker-compose
    alias dps="docker ps | docker-color-output"
    alias dcps="docker-compose ps -a | docker-color-output"
    alias dpi="docker images | docker-color-output"
    alias dpiarch="docker image inspect --format '{{.ID}} {{.RepoTags}} {{.Architecture}}' (docker image ls -q)"
    alias dshell="docker run -it --rm --entrypoint /bin/sh"
    alias dtop=lazydocker
    alias dclean="docker rmi -f (docker images -f "dangling=true" -q)"

    # postgres stuff
    # alias pgstart="brew services start postgresql"
    # alias pgstop="brew services stop postgresql"
    # alias pgtop=pg_top

    #alias start_minikube="minikube start --driver qemu --memory=4G --cpus=4 --disk-size=50g && eval (command minikube docker-env) && minikube addons enable ingress"
    #alias stop_minikube="minikube stop && eval (minikube docker-env -u)"
    #alias docker-env="eval (command minikube docker-env)"

    alias start_minikube="colima start -cpu 4 -m 6 -k"
    alias stop_minikube="colima stop"

    # fixes my typos
    alias gti=git

    alias tfp="terraform plan | scenery"
    alias tf=terraform

    alias npm=pnpm
    alias wrk2=oha

    # thats the best cli prompt
    if test -x (which starship)
        starship init fish | source
    end

    if test (command -v jump >/dev/null) -a (status --is-interactive)
      jump shell fish | source
    end

    # if command -v zoxide >/dev/null
    #   status --is-interactive; and source (zoxide init fish | psub)
    # end

    # Activate version from nearest .nvmrc file
    if test (type -t nvm) = "function"
      nvm use 
    end
end
