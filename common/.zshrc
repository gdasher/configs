# .zshrc - for interactive shells, after .zshenv.

#display time statistics if command runs for more than 10 seconds
REPORTTIME=10

HISTFILE="$HOME/.zsh_history"
HISTSIZE=50000
SAVEHIST=$HISTSIZE

#use shell built-ins for file tasks (prevents limits on arguments, etc.)
zmodload zsh/files

# test if colors are avaliable
# and confiugure the prompt accordingly
# normal prompt: user@host: ~ style dir !cmd num%  
# root prompt: <yellow on black> same with # at end
# if last cmd exited with non-zero status: same as normal except red on white

# maintain compatibility with fas files
if [[ $ISTYPE == "" ]]; then
  ISTYPE=`hostname -s`
fi

#fpath=(~/.zsh/functions $fpath)
#autoload -U ~/.zsh/functions/*(:t)

autoload colors zsh/terminfo
# Hack for iPhone client--do better soon
if [[ "$TERM" == "vt100" ]]; then
	PS1="%n@$ISTYPE:%~ %!%# "
elif [[ "$terminfo[colors]" -ge 8 || "$termcap[colors]" -ge 80 ]]; then
	colors
	source $HOME/.colors
	PS1="%{$thismachine%}%(#.%{${bg_no_bold[black]}${fg_no_bold[yellow]}%}.)%(?..%{${bg_no_bold[white]}${fg_no_bold[red]}%})%n@$ISTYPE:%~ %!%#%{${bg_no_bold[default]}${fg_no_bold[default]}%} "
else
	PS1="%n@$ISTYPE:%~ %!%# "
fi

#change the title of xterms to display user@host: ~ style directory
case $TERM in
    *xterm*|rxvt|(dt|k|E)term*)
        precmd () {print -Pn "\e]0;%n@$ISTYPE: %~\a"}
        ;;
esac

#always use vi keybindings
bindkey -v

#manually set lang variables on hcs, which has messed up locales
case $HOST in
	hcs)
		export LANGUAGE=en
		export LANG=en_US.UTF-8
 		;;
esac

export EDITOR=vi
export PAGER=less

# some tcsh stuff

bindkey "" beginning-of-line
run-fg-editor() {
  zle push-input
	BUFFER="fg %$EDITOR:t"
	zle accept-line
}

zle -N run-fg-editor


bindkey  '' run-fg-editor
bindkey '\eq' push-input
bindkey -s '' '\eqls\n'

#remap some cool commands that don't default in vi
bindkey 'h' run-help
bindkey '-' self-insert 

#read in aliases file
if [ -s $HOME/.aliases ]; then
   source $HOME/.aliases
fi

#read in custom shell functions
if [ -d $HOME/.functions ]; then
	for f in $HOME/.functions/*; do
		if [ -s $f ]; then
			source $f
		fi
	done	
fi

# tab complete hosts
_myhosts=( ${${${${(f)"$(<$HOME/.ssh/known_hosts)"}:#[0-9]*}%%\ *}%%,*} )
zstyle ':completion:*' hosts $_myhosts

which dircolors > /dev/null 2>&1

if [[ $? == 0 ]];then
  #color ls
  eval `dircolors`
  #and zsh
  zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
fi

#kill zstyle--force menu
zstyle ':completion:*:*:kill:*' menu yes select
zstyle ':completion:*:kill:*' force-list always

#caching

#directory stack coolness
DIRSTACKSIZE=8
setopt autopushd pushdminus pushdsilent pushdtohome pushdignoredups
alias dh='dirs -v'

#comments
setopt interactivecomments

#extended glob
setopt extendedglob

# history stuff
setopt extended_history
setopt inc_append_history  # instead of share_history
setopt hist_ignore_dups
setopt hist_no_store
bindkey '^R' history-incremental-search-backward
