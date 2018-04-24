if [[ ! $DISPLAY && $XDG_VTNR -eq 1 ]]; then
  exec startx
fi

if [ -n "$BASH" ] && [ -r ~/.bashrc ]; then
    . ~/.bashrc
fi

export PATH="${PATH}:$HOME/bin"
#export LANG="en_US.UTF-8"
export LANG=C.UTF-8
export PAGER=less
export MANWIDTH=80
export LESS='-F -g -i -M -R -S -w -X -z-4'
export EDITOR='emacs -fs'
export GIT_EDITOR='/usr/bin/emacs'
export TERM="/usr/bin/urxvt"
export CC=/usr/bin/clang
export CXX=/usr/bin/clang++
export GEM_HOME=$(ruby -e "print Gem.user_dir")
export GEM_PATH=$HOME/.gem
export DUNST_FONT='OfficeCodePro 7'
export DUNST_SIZE='250x20-30+30'
