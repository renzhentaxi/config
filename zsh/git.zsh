setopt shwordsplit 
setopt completealiases

checkout_gitwork()
{
    worktreeDir=../$1
    rest=$*[2,-1]
    git worktree add $worktreeDir $rest
    ln -s $(pwd)/node_modules $worktreeDir/node_modules
    cd $worktreeDir
    return
}

alias gwtc=checkout_gitwork
alias gwtr=git worktree remove
