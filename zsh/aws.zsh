export PATH=/usr/local/bin/aws_completer/:$PATH

autoload bashcompinit && bashcompinit
autoload -Uz compinit && compinit

complete -C '/usr/local/bin/aws_completer' aws
