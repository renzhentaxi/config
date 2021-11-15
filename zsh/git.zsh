is_git_repo()
{
    git -C $1 rev-parse 2>/dev/null
    return $?
}

git_worktree_checkout()
{
    if ! is_git_repo .; then
        echo 'not in a git repo!'
        return 1
    fi

    worktreeDir=../$1
    rest=($*[2,-1])

    cd $(git worktree list | head -n 1 | cut -d " " -f1)
    git pull

    git worktree add $worktreeDir $rest

    sourceNodeModule=$(realpath node_modules)
    targetNodeModule=$(realpath $worktreeDir/node_modules)
    ln -s $sourceNodeModule $targetNodeModule

    cd $worktreeDir
    return
}

alias gwtc=git_worktree_checkout


alias reload="source ~/.config/zsh/git.zsh"
alias edit="nvim ~/.config/zsh/git.zsh"
