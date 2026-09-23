# The following lines were added by Docker Desktop to add commands to your PATH.
export PATH="$PATH:/Users/bearn/.docker/bin"
# End of Docker Desktop section.

eval "$(/opt/homebrew/bin/brew shellenv zsh)"

# including libs


# scripts
export PATH="$PATH:$HOME/Documents/dotfiles/scripts"

# homebrew
export HOMEBREW_PREFIX="/opt/homebrew";
export HOMEBREW_CELLAR="/opt/homebrew/Cellar";
export HOMEBREW_REPOSITORY="/opt/homebrew";

export PATH="$PATH:/opt/homebrew/opt/llvm/bin"
export PATH="/opt/homebrew/bin:$PATH"
export PATH="$PATH:/opt/homebrew/bin/node"

# >>> coursier install directory >>>
export PATH="$PATH:/Users/bearn/Library/Application Support/Coursier/bin"
# <<< coursier install directory <<<
