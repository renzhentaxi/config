#!/usr/bin/env bash

TB_REPO_DIRECTORY=$HOME/git_repos

isNotInstalled() {
	if which $1 >/dev/null 2>&1; then
		return 1
	else
		return 0
	fi
}

ensureGitRepo() {
	local repoURL=$1
	local repoName
	if [ ! -z $2 ]; then
		repoName=$2
	else
		repoName=$(basename $1)
	fi

	mkdir -p $TB_REPO_DIRECTORY

	local repoDirectory=$TB_REPO_DIRECTORY/$repoName
	cd $TB_REPO_DIRECTORY

	if [ -d $repoName ]; then
		cd $repoName
		git pull
		cd ..
	else
		git clone $repoURL $repoName
	fi

	cd $repoName
	if [ -f .gitmodules ]; then
		git submodule update --init --recursive
	fi
	cd ..

}

ensureInstalledSingle() {
	case $1 in
	rust | cargo)
		if isNotInstalled rustup; then
			curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
		fi
		;;
	stylua)
		ensureInstalled rust
		if isNotInstalled $1; then
			cargo install $1
		fi
		;;
	go)
		if isNotInstalled go; then
			echo todo
		fi
		;;
    gopls)
        ensureInstalled go 
        if isNotInstalled gopls; then
            go install golang.org/x/tools/gopls@latest 
        fi
        ;;
	shfmt)
		ensureInstalled go
		if isNotInstalled shfmt; then
			go install mvdan.cc/sh/v3/cmd/shfmt@latest
		fi
		;;
	lua-language-server)
		ensureGitRepo https://github.com/sumneko/lua-language-server
		# git clone https://github.com/sumneko/lua-language-server
		# cd lua-language-server
		# git submodule update --init --recursive
		# cd 3rd/luamake
		# ./compile/install.sh
		# cd ../..
		# ./3rd/luamake/luamake rebuild
		;;
	*)
		echo "unknown dep $1"
		return 1
		;;
	esac
	echo ensured $1
}

ensureInstalled() {
	local var
	for var in "$@"; do
		ensureInstalledSingle $var
	done
}

# lua
ensureInstalled stylua lua-language-server

# go
ensureInstalled gopls

# bash formatter
ensureInstalled shfmt
