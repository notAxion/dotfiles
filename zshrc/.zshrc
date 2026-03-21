# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

#use a history file in here
HISTFILE=$HOME/.zsh_history
# make it huge, really huge.
SAVEHIST=1000000
HISTSIZE=1000000

# there is for sure still some redundancy, but ...
# setopt BANG_HIST                 # Treat the '!' character specially during expansion.
# setopt EXTENDED_HISTORY          # Write the history file in the ":start:elapsed;command" format.
setopt INC_APPEND_HISTORY        # Write to the history file immediately, not when the shell exits.
setopt SHARE_HISTORY             # Share history between all sessions.
setopt HIST_EXPIRE_DUPS_FIRST    # Expire duplicate entries first when trimming history.
setopt HIST_IGNORE_DUPS          # Don't record an entry that was just recorded again.
setopt HIST_IGNORE_ALL_DUPS      # Delete old recorded entry if new entry is a duplicate.
setopt HIST_FIND_NO_DUPS         # Do not display a line previously found.
setopt HIST_IGNORE_SPACE         # Don't record an entry starting with a space.
setopt HIST_SAVE_NO_DUPS         # Don't write duplicate entries in the history file.
setopt HIST_REDUCE_BLANKS        # Remove superfluous blanks before recording entry.
#setopt HIST_VERIFY               # Don't execute immediately upon history expansion.
#setopt HIST_BEEP                 # Beep when accessing nonexistent history.

alias history="history 0"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="powerlevel10k/powerlevel10k"
# ZSH_THEME="agnoster"
# ZSH_THEME="bira"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to automatically update without prompting.
# DISABLE_UPDATE_PROMPT="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
ENABLE_CORRECTION="true"
alias cmd.exe="nocorrect cmd.exe"

# Uncomment the following line to display red dots whilst waiting for completion.
# Caution: this setting can cause issues with multiline prompts (zsh 5.7.1 and newer seem to work)
# See https://github.com/ohmyzsh/ohmyzsh/issues/5765
COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.

ZVM_SYSTEM_CLIPBOARD_ENABLED=true

# default copy command was wl-copy
if [[ $XDG_SESSION_TYPE == "x11" ]]; then
	ZVM_CLIPBOARD_COPY_CMD='xclip -selection clipboard'
	ZVM_CLIPBOARD_PASTE_CMD='xclip -selection clipboard -o'
# else
# maybe wayland copy command wl-copy and wl-paste
fi

# Use lf to switch directories and bind it to ctrl-o
lfcd () {
    tmp="$(mktemp)"
    lf -last-dir-path="$tmp" "$@"
    if [ -f "$tmp" ]; then
        dir="$(cat "$tmp")"
        rm -f "$tmp"
        [ -d "$dir" ] && [ "$dir" != "$(pwd)" ] && cd "$dir"
    fi
}
bindkey -s '^o' 'lfcd\n'
local lf_icons="$HOME/.config/lf/lf-icons"
if [[ -a "$lf_icons" ]]; then
	source "$lf_icons"
fi

function zvm_after_init() {
	eval "$(mcfly init zsh)"
	zvm_bindkey vicmd '^O' 'lfcd\n'
}

# Skip only aliases defined in the directories.zsh lib file
zstyle ':omz:lib:directories' aliases no

# Skip all plugin aliases
zstyle ':omz:plugins:*' aliases no


plugins=(
	git
	zsh-autosuggestions
	docker
	docker-compose
	zsh-syntax-highlighting
	zsh-vi-mode
	autoswitch_virtualenv
)

source $ZSH/oh-my-zsh.sh

# User configuration

# Turn off all beeps
unsetopt BEEP
# Turn off autocomplete beeps
unsetopt LIST_BEEP

# Basic auto/tab complete:
autoload -U compinit
zstyle ':completion:*' menu select
setopt auto_menu menu_complete
zmodload zsh/complist
compinit
_comp_options+=(globdots)		# Include hidden files.

# some more ls aliases
# alias ll='ls -alF'
alias ll='exa -lam -s type --git --icons'

# alias la='ls -A'
alias la='exa -lam -s type --no-permissions --no-user'

alias ls='exa -s type --icons'

alias l='exa -1a -s type'
# alias l='ls -CF'

# CD ALIASES
alias cd..='cd ..'

# temp aliases 
alias zshrc="$EDITOR ~/.zshrc"
alias rezshrc=". ~/.zshrc"

# some alias for git 
alias gits='git status'
alias gitc='git commit'
alias gitaa='git add .'
alias gitp='git push'

# don't want vim anymore nvim all the way
alias vim='nvim'

# global aliases, replace this with that
alias -g NE='2>/dev/null'
alias -g DN='> /dev/null'
alias -g NUL='>/dev/null 2>&1'

alias md='mkdir -p'

# some extra funcs for me 
mkcd() {
	mkdir -pv "$1"
	cd "$1"
}
mct() {
	mkdir -pv "$1"
	cd "$1"
	if [ -z "$2" ]
	then
		touch main.go
	else
		#for ((i=2;i<=$#;i++))
		#do
		#	touch ${!i}
		#done
		for i in "${@:2}"
		do
		    touch "$i"
		done

	fi
}

# Golang exports
export GOBIN="$HOME/go/bin"
export PATH="$PATH:$GOBIN"

# dart pub bin 
export PATH="$PATH":"$HOME/.pub-cache/bin"

jdk() {
    version=$1
    export JAVA_HOME=$(/usr/libexec/java_home -v"$version");
    java -version
}

maven() {
	if [ $# -eq 0 ]; then 
		echo "eg: maven new <project_name>"
	elif [[ $1 == "new" ]]; then
		local project_name=""
		if [ -z "$2" ]; then
			project_name="example"
		else
			project_name="$2"
		fi
		mvn archetype:generate -DarchetypeArtifactId=maven-archetype-quickstart -DarchetypeVersion=1.4 -DinteractiveMode=false -DgroupId=com."$project_name" -DartifactId="$project_name"
	else
		echo "eg: maven new <project_name>"
	fi
}

alias neofetch="neofetch --source ~/.config/neofetch/spider.txt"
alias avd="/Users/06xhello/Library/Android/sdk/tools/emulator -avd Pixel_2_XL_API_25 >> /dev/null 2>&1 &"
alias minecraft="java -jar ~/files/games/TLauncher-2.841/TLauncher-2.871.jar"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='nvim'
fi

# i don't think this works well
# alias cursor="nohup $HOME/.local/Cursor/cursor.appimage $@ &> /dev/null"

[ -s "$HOME/.inveesync.zsh" ] && source "$HOME/.inveesync.zsh"


# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
# neofetch
## [Completion] 
## Completion scripts setup. Remove the following line to uninstall
# [[ -f /Users/06xhello/.dart-cli-completion/zsh-config.zsh ]] && . /Users/06xhello/.dart-cli-completion/zsh-config.zsh || true
## [/Completion]

# opencode completions
[ -s "$HOME/.local/share/opencode/_opencode" ] && source "$HOME/.local/share/opencode/_opencode"

# gh completions
[ -s "$HOME/.local/share/github-cli/_gh" ] && source "$HOME/.local/share/github-cli/_gh"

eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"

zvm_after_init

# bun completions
[ -s "$HOME/.bun/_bun" ] && source "$HOME/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"
