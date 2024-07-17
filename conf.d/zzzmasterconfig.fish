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
    set -x BAT_THEME "Dracula"

    # set -x LESS_TERMCAP_mb $'\e[1;31m'      # begin bold
    # set -x LESS_TERMCAP_md $'\e[1;34m'      # begin blink
    # set -x LESS_TERMCAP_so $'\e[01;45;37m'  # begin reverse video
    # set -x LESS_TERMCAP_us $'\e[01;36m'     # begin underline
    # set -x LESS_TERMCAP_me $'\e[0m'         # reset bold/blink
    # set -x LESS_TERMCAP_se $'\e[0m'         # reset reverse video
    # set -x LESS_TERMCAP_ue $'\e[0m'         # reset underline
    # set -x GROFF_NO_SGR 1                   # for konsole

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
    alias jq=jaq
    alias grep=ugrep
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
    alias diff=delta
    alias httpie=xh
    alias publicip='curl ifconfig.me'
    #alias cp='rsync --progress -avz --ignore-existing'
    alias update='brew update;brew upgrade;brew uninstall -q --ignore-dependencies node;brew uninstall -q --ignore-dependencies openjdk; brew uninstall -q --ignore-dependencies temurin;brew autoremove;brew cleanup; pnpm update -g'
    #alias mrproper="fd -t f .DS_Store -x rm {}; fd --exclude '.vscode/*' -t d node_modules -x rm -rf {}"
    alias mrproper=kondo

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

    alias nmap=rustscan

    # kshell podname /bin/sh
    alias kshell="kubectl iexec"
    alias krbac="kubectl access-matrix"

    # specific osx aliases
    if test (uname) = "Darwin"
        # alias subl=code
        #set -x EDITOR "subl -w"
        set -x EDITOR "code"
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

    alias start_docker="colima start -c 4 -m 6 -k"
    alias stop_docker="colima stop"

    # fixes my typos
    alias gti=git

    alias tfp="terraform plan | scenery"
    alias tf=terraform

    #alias npm=pnpm
    alias wrk2=oha

    # thats the best cli prompt
    if test -x (which starship)
        starship init fish | source
    end

    if test (command -v jump >/dev/null) -a (status --is-interactive)
      jump shell fish | source
    end

    # Activate version from nearest .nvmrc file
    if test (type -t nvm) = "function"
      nvm use 
    end
end
