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
    alias dps="grc docker ps"
    alias dpi="grc docker images"
    alias dshell="docker run -it --rm --entrypoint /bin/sh"
    alias dc=docker-compose
    alias pgstart="brew services start postgresql"
    alias pgstop="brew services stop postgresql"
    alias pgtop=pg_top

    # fixes my typos
    alias gti=git
    alias sl=ls

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

