#nvim
alias vi=nvim
export EDITOR='nvim'
export VISUAL='nvim'

#general
export XDG_CONFIG_HOME=~/.config
export PATH="/usr/local/opt/gnu-sed/libexec/gnubin:$PATH"

zshDir=$XDG_CONFIG_HOME/zsh #todo: is this actually being used?

#nvm
source $zshDir/nvm.zsh

#simple prompt
source $zshDir/pure.zsh

#aws
source $zshDir/aws.zsh

#git
source $zshDir/git.zsh

#theme = snazzy

#highlghts stuff in zsh shell
source $HOME/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

#vim like keybind
bindkey -v

export PATH="$HOME/go/bin:$PATH"
# Add pyenv executable to PATH and
# enable shims by adding the following
# to ~/.profile and ~/.zprofile:

export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init --path)"

# Load pyenv into the shell by adding
# the following to ~/.zshrc:

eval "$(pyenv init -)"

# Make sure to restart your entire logon session
# for changes to profile files to take effect.
