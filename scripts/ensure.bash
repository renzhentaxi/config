#!/bin/bash
set -euo pipefail
IFS=$'\n\t'

function is_function() {
	local func_name=$1
	[[ "$(type -t $func_name)" == 'function' ]]
}

function is_present() {
	local command_name=$1
	local filetype=$(type -t $command_name)
	[[ ! -z $filetype ]]
}

function ensure() {
	local prog=$1
	local func_name=ensure_$prog

	if is_function $func_name; then
		$func_name ${@:2}
		return $?
	else
		echo "Unknown task type: $prog"
	fi
	return 1
}

function ensure_pacman() {
	echo "not implemented: pacman"
	return 1
}

function parse_git_repo_path() {
	local repo_path=$1
	if [[ ! $repo_path =~ ^https?://.+$ ]]; then
		repo_path="https://github.com/$repo_path"
	fi
	echo $repo_path
}

# basically the last part of the url
function parse_git_repo_name() {
	local repo_path=$1
	IFS='/' read -a parts <<<$repo_path
	echo ${parts[-1]}
}

function ensure_git() {
	echo "executing git"
	local error=0
	local repo_path=$(parse_git_repo_path $1)
	local repo_name=$(parse_git_repo_name $repo_path)
	local directory_path="$ENSURE_DOWNLOAD_DIR/$repo_name"
	echo "repo_path: $repo_path"
	echo "repo_name: $repo_name"
	echo "directory: $directory_path"

	if [ -d $directory_path ]; then
		echo "git: pull start"
		git pull || error=1
		echo "git: pulled end"
	else
		echo "git: clone start"
		git clone --depth 1 --branch master $repo_path $directory_path || error=1
		echo "git: clone end"
	fi

	return $error
}

function ensure_apt() {
	if is_present apt; then
		echo "Executing sudo apt-get install -qq ${@}"

		if sudo apt-get update -qq && sudo apt-get install -qq ${@}; then
			echo "success: apt"
			return 0
		else
			echo "fail: apt"
		fi
	fi
	return 1
}

function ensure_make() {
	local prevDir=$(pwd)
	local folder=$1
	local make_path=$ENSURE_DOWNLOAD_DIR/$folder
	local additional_args=${@:2}
	local error=0

	cd $make_path && sudo make $additional_args || error=1

	cd $prevDir

	return $error
}
