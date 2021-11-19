stripName()
{
    name=taxi/
    echo ${1#$name}
}

is_git_repo()
{
    git -C $1 rev-parse 2>/dev/null
    return $?
}

git_main_branch()
{

    echo $(basename $(git rev-parse --abbrev-ref origin/HEAD))
}

git_current_branch()
{
    echo $(git rev-parse --abbrev-ref HEAD)
}

git_worktree_checkout()
{
    if ! is_git_repo .; then
        echo 'not in a git repo!'
        return 1
    fi

    worktreeDir=../$1
    rest=($*[2,-2])
    branchName=$(stripName $*[-1])

    cd $(git worktree list | head -n 1 | cut -d " " -f1)
    git pull
     
    git worktree add $worktreeDir $rest $branchName

    sourceNodeModule=$(realpath node_modules)
    targetNodeModule=$(realpath $worktreeDir/node_modules)
    ln -s $sourceNodeModule $targetNodeModule

    cd $worktreeDir
    return
}

git_worktree_switch()
{
    cd `git worktree list | fzf | cut -d " " -f 1`
}

alias gwtc=git_worktree_checkout
alias gwts=git_worktree_switch

alias gpuo='git push -u origin $(git_current_branch)'
alias gprc='gh pr create --title $(git_current_branch)'
alias gprd='git diff --name-only $(git_main_branch)...'

alias reload="source ~/.config/zsh/git.zsh"
alias edit="nvim ~/.config/zsh/git.zsh"
