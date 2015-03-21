if [[ $TERM == "dumb" ]]; then	# in emacs
    PS1='%(?..[%?])%!:%~%# '
    # for tramp to not hang, need the following. cf:
    # http://www.emacswiki.org/emacs/TrampMode
    unsetopt zle
    unsetopt prompt_cr
    unsetopt prompt_subst
    unfunction precmd
    unfunction preexec
else


# alias startxfb = "setenv FRAMEBUFFER /dev/fb\!*; # Set the env var to the cmd arg. con2fb $FRAMEBUFFER /dev/$tty; # Move the fb to the current tty. fbset -fb $FRAMEBUFFER 1920x1200@62; # Favorite from /etc/fb.modes startx -- :\!* -bpp 16 vt0`echo $tty | cut -dy f 2`' # X on this tty. "

dual () {
    xrandr --output HDMI1 --primary --left-of VGA1 --output VGA1 --auto
}

zstyle :omz:plugins:ssh-agent identities $(grep -rl 'PRIVATE KEY' .ssh | xargs -I {} basename {})


#xrandr --output VGA1 --auto --output HDMI1 --auto --left-of VGA1

    if [ ! -d $HOME/antigen ]; then
        git clone https://github.com/zsh-users/antigen.git $HOME/antigen
    fi

    source $HOME/antigen/antigen.zsh

    # Load the oh-my-zsh library
    antigen use oh-my-zsh

    # Bundles from the default repo (robbyrussel's oh-my-zsh)
    antigen-bundles <<EOF

git
git-extras
git-remote-branch
pip

zsh-users/zsh-syntax-highlighting

EOF

    # Themes
    antigen-theme kphoen

    antigen-apply

    unsetopt correct_all

    if [ ! -S "${SSH_AUTH_SOCK}" ]; then;
        antigen bundle ssh-agent
    fi
    
fi




export PATH=$HOME/bin:/opt/chefdk/embedded/bin/:$PATH
export EDITOR="emacsclient"
export ALTERNATE_EDITOR=""

alias erl='rlwrap -a erl'

if which virtualenvwrapper.sh >/dev/null; then
    source virtualenvwrapper.sh
fi

if [ -d ${HOME}/.cabal/bin ]; then
    export PATH="${HOME}/.cabal/bin:$PATH"
fi

if [[ -n "$DISPLAY" ]]; then
    if [ `qdbus | grep konsole` ]; then
        xprop -f _KDE_NET_WM_BLUR_BEHIND_REGION 32c -set _KDE_NET_WM_BLUR_BEHIND_REGION 0 -id `qdbus org.kde.konsole /konsole/MainWindow_1 winId`;
    fi
    if [ `qdbus | grep yakuake` ]; then
        xprop -f _KDE_NET_WM_BLUR_BEHIND_REGION 32c -set _KDE_NET_WM_BLUR_BEHIND_REGION 0 -name Yakuake;
    fi
fi

if [[ -s $HOME/.nvm/nvm.sh ]] then; . $HOME/.nvm/nvm.sh; fi; # This loads NVM
    
