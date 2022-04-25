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

has_remote_branch()
{
    hasRemote=$(git ls-remote --heads origin $1)
    test ! -z $hasRemote
    return $?
}

safe_branch_name()
{
    echo $(echo $1 | tr '/' '-')
}

git_worktree_checkout()
{
    if ! is_git_repo .; then
        echo 'not in a git repo!'
        return 1
    fi
    
    if [ "$#" -eq 0 ]; then
        remote_branches=$(git branch -r --format "%(refname:short)" | cut -d/ -f2-)
        local_branches=$(git branch --format "%(refname:short)")
        all_branches=$({echo $remote_branches; echo $local_branches} | sort | uniq)
        
        branchName=$(echo $all_branches | fzf)
    else 
        if [ $1 = '-b' ]; then
            is_new_branch='-b'
            branchName=$(stripName $2)
        else
            is_new_branch=''
            branchName=$(stripName $1)
        fi
    fi
    
    worktreeDir=../$(safe_branch_name $branchName)
    
    git worktree add $worktreeDir $is_new_branch $branchName
    if [ $? -ne 0 ] ; then
        return 1
    fi
    
    # symlink node modules
    sourceNodeModule=$(realpath node_modules)
    targetNodeModule=$(realpath $worktreeDir/node_modules)
    ln -s $sourceNodeModule $targetNodeModule
    
    cd $worktreeDir
    return
}

git_worktree_switch()
{
    if ! is_git_repo .; then
        echo 'not in a git repo!'
        return 1
    fi
    directory=`git worktree list | fzf | cut -d " " -f 1` 
    if [ -n "${directory}" ] ; then;
        cd $directory && has_remote_branch $(git_current_branch) && git pull
    fi
}

alias gwtc=git_worktree_checkout
alias gwts=git_worktree_switch
alias gwtr="git worktree list | cut -f1 -w | fzf -m | xargs -n1 git worktree remove --force"
alias gpuo='git push -u origin $(git_current_branch)'
alias grho='git reset --hard origin/$(git_current_branch)'
alias gprc='gh pr create --title $(git_current_branch)'
alias gprd='git diff --name-only $(git_main_branch)...'
alias reload="source ~/.config/zsh/git.zsh"
alias edit="nvim ~/.config/zsh/git.zsh"
