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
alias ll='ls -lah'
alias grep='grep --color=auto'
alias rmusic='yt-dlp -f "bestaudio" --extract-audio --audio-format flac --audio-quality 0 -P ~/Music/mpd/'

# Apps/Util
export PATH="$PATH:/Applications/Obsidian.app/Contents/MacOS"

# Git prompt (simple + safe)
autoload -Uz vcs_info
precmd() { vcs_info }
zstyle ':vcs_info:git:*' formats '(%b)'
setopt PROMPT_SUBST

# PS1
PROMPT='%F{green}%*%f %F{cyan}%n%f %F{blue}%~%f %F{red}${vcs_info_msg_0_}%f$ '

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
