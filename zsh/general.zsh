alias vi=nvim

export XDG_CONFIG_HOME=~/.config
export EDITOR='nvim'

zshDir=$XDG_CONFIG_HOME/zsh

source $XDG_CONFIG_HOME/zsh/nvm.zsh

#simple prompt
source $XDG_CONFIG_HOME/zsh/pure.zsh
#aws
source $XDG_CONFIG_HOME/zsh/aws.zsh
source $zshDir/git.zsh 

#theme = snazzy
#highlghts stuff in zsh shell
source $HOME/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

bindkey -v

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
