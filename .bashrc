#export PS1="$(context-color -p)$PS1\[\e[0m\]"

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

if [[ $- != *i* ]]; then
  return
fi

export FZF_DEFAULT_COMMAND='rg --files --no-ignore --hidden --follow --glob "!.git/*"'

shopt -s histappend
PROMPT_COMMAND='history -a'
HISTCONTROL=ignoredups:ignorespace

# Auto-correct misspelled directories
shopt -s dirspell direxpand

# Check the window size after each command and, if necessary,
# Update the values of LINES and COLUMNS.
shopt -s checkwinsize

# The pattern "**" used in a pathname expansion context will
# Match all files and zero or more directories and subdirectories.
shopt -s globstar

# Extended pattern matching features are enabled
shopt -s extglob

# Include filenames beginning with a '.' in the results of pathname expansions
shopt -s dotglob

# Reclaim Ctrl-S and Ctrl-Q used for suspend/resume and use it for modern mapppings
stty -hupcl -ixon -ixoff
stty stop undef
stty susp undef

# xterm title:
case "$TERM" in
xterm*|rxvt*)
    PROMPT_COMMAND='echo -ne "\n\033]0;${USER}@${HOSTNAME}: ${PWD}\007"'
    ;;
*)
    ;;
esac

## Aliases
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias src='source ~/.bashrc'
alias free='free -mt'
#alias ll='ls -alF'
#alias la='ls -A'
alias l='ls -CF'
#alias ls='ls -hBG'
alias l.='ls -d .*'
#alias l.="ls -A | egrep '^\.'" 
alias ls="ls --group-directories-first --time-style=+'%d.%m.%Y %H:%M' --color=auto -hFX"
alias ll="ls -l --group-directories-first --time-style=+'%d.%m.%Y %H:%M' --color=auto -F"
alias la="ls -la --group-directories-first --time-style=+'%d.%m.%Y %H:%M' --color=auto -F"
alias fuck="sudo !!"
alias git-source='git config --get remote.origin.url'
alias glg='git log --graph --pretty=format":%C(yellow)%h%Cblue%d%Creset %s %C(white) %an,%ar%Creset" --abbrev-commit --decorate'
alias glgh='git log --graph --pretty=format":%C(yellow)%h%Cblue%d%Creset %s %C(white) %an,%ar%Creset" --abbrev-commit --decorate | head'
alias glo='git log --oneline --decorate'
alias gloh='git log --oneline --decorate | head'
alias path='echo $PATH | tr -s ":" "\n"'
alias mount='mount |column -t'
alias mkdir="mkd"
alias getip='grep -oE "\b((25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.){3}(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\b"'

# View and set wallpaper with feh
alias feh-view="feh --scale-down --auto-zoom"
alias feh-set="feh --bg-fill"

# Add an "alert" alias for long running commands.  Use like so:
# sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# requires installing tool "opting"
## Use: optimize image.png
alias optimize="optipng -o7 -f4 -strip all -quiet"

# faster bundle
alias bundle3="bundle install -j3"
alias bundle_project="bundle install -j3 --path vendor/bundle"

# bindings
bind -r "\C-l" && bind "\C-l":clear-screen
bind -r "\C-e" && bind "\C-e":end-of-line
bind -r "\C-p" && bind "\C-p":history-search-backward
bind -r "\C-n" && bind "\C-n":history-search-forward

cdls() { cd "$@" && ls; } # Combo command
alias cd='cdls'

retry() {
    if eval "$@"; then
        return 0
    fi

    for i in 2 1; do
        sleep 3s
        echo "Retrying $i..."
        if eval "$@"; then
            return 0
        fi
    done
    return 1
}


## Functions
function cd() {
    builtin cd $@ && ls
}

# Back up a file. Usage "backfile filename.txt"
backupthis ()
{
    cp $1 ${1}-`date +%Y%m%d%H%M`.backup;
}

clean() {
rm -rf "$HOME/.cache/"
rm -rf "$HOME/.thumbnails"
rm -rf "$HOME/.local/share/Trash"
}

md_to_pdf() {
pandoc --latex-engine=xelatex -V mainfont="Times New Roman" -V fontsize=12pt -V geometry:margin=1in -V documentclass=article -V linestrech=1.5 -V link-as-notes $1.md -s -o $2.pdf
}

# Create a new directory and enter it
mkd() { mkdir $1 && cd $1; }

gacp () {
  git add --all --verbose
  git commit -m "$1"
  git push -u origin HEAD
}
## Interesting bash function for setting up a new front-end project
# Usage: new_project DIRNAME DESCRIPTION
function new_project() {
  git init "$1" && \
	  pushd "$1" && \
	  echo "$2" > README.txt && \
	  echo "$2" > .git/description && \
	  echo "/node_modules/" >> .gitignore && \
	  hub create -d "$2" && \
	  yarn init && \
	  gacp initial
}

# Create new web project folder and grab html5 boilerplate
website() {
mkdir $1
cd $1
git init
git remote add origin https://github.com/Gazaunga/HTML5-Boilerplate.git
git pull origin master
ls -a
$EDITOR index.html
}

# Tar extraction
extract() {      # Handy Extract Program
    if [ -f $1 ] ; then
        case $1 in
            *.tar.bz2)   tar xvjf $1     ;;
            *.tar.gz)    tar xvzf $1     ;;
            *.bz2)       bunzip2 $1      ;;
            *.rar)       unrar x $1      ;;
            *.gz)        gunzip $1       ;;
            *.tar)       tar xvf $1      ;;
            *.tbz2)      tar xvjf $1     ;;
            *.tgz)       tar xvzf $1     ;;
            *.zip)       unzip $1        ;;
            *.Z)         uncompress $1   ;;
            *.7z)        7z x $1         ;;
            *)           echo "'$1' cannot be extracted via >extract<" ;;
        esac
    else
        echo "'$1' is not a valid file!"
    fi
}

# Create a .tar.gz archive, using `zopfli`, `pigz` or `gzip` for compression
function targz() {
	local tmpFile="${@%/}.tar";
	tar -cvf "${tmpFile}" --exclude=".DS_Store" "${@}" || return 1;

	size=$(
		stat -f"%z" "${tmpFile}" 2> /dev/null; # macOS `stat`
		stat -c"%s" "${tmpFile}" 2> /dev/null;  # GNU `stat`
	);

	local cmd="";
	if (( size < 52428800 )) && hash zopfli 2> /dev/null; then
		# the .tar file is smaller than 50 MB and Zopfli is available; use it
		cmd="zopfli";
	else
		if hash pigz 2> /dev/null; then
			cmd="pigz";
		else
			cmd="gzip";
		fi;
	fi;

	echo "Compressing .tar ($((size / 1000)) kB) using \`${cmd}\`…";
	"${cmd}" -v "${tmpFile}" || return 1;
	[ -f "${tmpFile}" ] && rm "${tmpFile}";

	zippedSize=$(
		stat -f"%z" "${tmpFile}.gz" 2> /dev/null; # macOS `stat`
		stat -c"%s" "${tmpFile}.gz" 2> /dev/null; # GNU `stat`
	);

	echo "${tmpFile}.gz ($((zippedSize / 1000)) kB) created successfully.";
}

scripter()
{
    if [ -n "$1" ]; then
        local script="$1"
    else
        local script=`mktemp scriptster.rb.XXXX`
    fi

    local url="https://raw.githubusercontent.com/pazdera/scriptster/master"
    curl "$url/examples/minimal-template.rb" >"$script"
    #curl "$url/examples/documented-template.rb" >"$script"

    chmod +x "$script"
    $EDITOR "$script"
}

. ~/bin/utils
