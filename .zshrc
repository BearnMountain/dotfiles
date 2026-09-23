# Core Zsh setup

autoload -U compinit
compinit -d ~/.cache/zsh/zcompdump

setopt autocd
setopt extendedglob
setopt hist_ignore_space
setopt hist_ignore_dups
setopt share_history

HISTSIZE=5000
SAVEHIST=5000
HISTFILE="$HOME/.zsh_history"

# PATH (Homebrew first)
eval "$(/opt/homebrew/bin/brew shellenv)"

export PATH="$HOME/.local/bin:$PATH"
export PATH="/opt/homebrew/bin:$PATH"
export PATH="/opt/homebrew/opt/bison/bin:$PATH"
export PATH="/opt/homebrew/opt/flex/bin:$PATH"

# Rust
export PATH="$HOME/.cargo/bin:$PATH"

# Python
if command -v pyenv >/dev/null 2>&1; then
  eval "$(pyenv init - zsh)"
fi

# Neovim
export EDITOR="nvim"
export VISUAL="nvim"

# Aliases
alias ls='ls -G --color=auto'
# alias ll='ls -lah'
alias grep='grep --color=auto'
alias rmusic='yt-dlp -f "bestaudio" --extract-audio --audio-format flac --audio-quality 0 -P ~/Music/mpd/'
alias dtwt='npx twt-dl-cli@latest'
alias wgetpage='wget --mirror --convert-links --adjust-extension --page-requisites --no-parent'


# Apps/Util
export PATH="$PATH:/Applications/Obsidian.app/Contents/MacOS"

# Git prompt (simple + safe)
autoload -Uz vcs_info
precmd() { vcs_info }
zstyle ':vcs_info:git:*' formats '(%b)'
setopt PROMPT_SUBST

# ---- Terminal Configuration ----
hex_color() {
    local hex="${1#\#}"

    printf '\e[38;2;%d;%d;%dm' \
        "0x${hex[1,2]}" \
        "0x${hex[3,4]}" \
        "0x${hex[5,6]}"
}

# PS1
# Earth
# COLOR_TIME=$'\e[38;2;82;121;111m'
# COLOR_USER=$'\e[38;2;132;169;140m'
# COLOR_PATH=$'\e[38;2;202;210;197m'
# COLOR_VCS=$'\e[38;2;157;2;8m'

COLOR_TIME=$(hex_color "#3e5641")
COLOR_USER=$(hex_color "#84a98c")
COLOR_PATH=$(hex_color "#cad2c5")
COLOR_VCS=$(hex_color  "#9d0208")

# COLOR_TIME=$'\e[38;2;62;86;65m'
# COLOR_USER=$'\e[38;2;162;73;54m'
# COLOR_PATH=$'\e[38;2;211;97;53m'
# COLOR_VCS=$'\e[38;2;131;181;169m'

# Sonakai
# COLOR_TIME=$'\e[38;2;198;125;148m'   # muted pink
# COLOR_USER=$'\e[38;2;214;146;103m'   # muted orange
# COLOR_PATH=$'\e[38;2;196;185;109m'   # muted yellow
# COLOR_VCS=$'\e[38;2;126;157;126m'    # muted green

RESET=$'\e[0m'

PROMPT="%{${COLOR_TIME}%}%*%{${RESET}%} %{${COLOR_USER}%}%n%{${RESET}%} %{${COLOR_PATH}%}%1~%{${RESET}%} %{${COLOR_VCS}%}\${vcs_info_msg_0_}%{${RESET}%}$ "
# keybinds
bindkey "^K" up-line-or-history # navigate history
bindkey "^J" down-line-or-history

bindkey "^a" beginning-of-line

# macOS / dev tools
export LDFLAGS="-L/opt/homebrew/lib"
export CPPFLAGS="-I/opt/homebrew/include"

# redirect files
export TERMINFO="$HOME/.config/.terminfo"
export LESSHISTFILE="$HOME/.cache/less/history"
export SQLITE_HISTORY="$HOME/.cache/sqlite/history"

# Embedded / STM32 (optional)
# export STM32CubeMX_PATH="/Applications/STM32CubeMX.app/Contents/Resources"
# export STM32_PRG_PATH="/Applications/STMicroelectronics/STM32Cube/STM32CubeProgrammer/.../bin"
export PATH="$HOME/.local/share/nvim/mason/bin:$PATH"
export PATH="$HOME/.cargo/bin:$PATH"
export PATH="/opt/homebrew/opt/openjdk/bin:$PATH"
export JAVA_HOME="/opt/homebrew/opt/openjdk/libexec/openjdk.jdk/Contents/Home"
# The following lines have been added by Docker Desktop to enable Docker CLI completions.
fpath=(/Users/bearn/.docker/completions $fpath)
autoload -Uz compinit
(( ${+_comps[docker]} )) || compinit
# End of Docker CLI completions
