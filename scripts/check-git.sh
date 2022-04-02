# tries to keep your branch updated
# exit code 1: no updates
# exit code 0: either pulled/ or cloned
url=$1
directory=$2
branch=$3

if [ -z $branch ]; then
	branch="master"
fi

if [ -d $directory ]; then
	cd $directory

	echo "check-git: fetching git"
	# fetch current branch
	git fetch -q origin $(git branch --show-current)

	localHash=$(git rev-parse @)
	remoteHash=$(git rev-parse @{u})

	# compare hash
	if [ $localHash = $remoteHash ]; then

		echo "$0: no updates"
		exit 1
	else
		echo "$0: has updates"
		git pull -q
		git submodule update --init --recursive
		echo "$0: finish updating"
		exit 0
	fi

else
	echo "$0: started cloning"
	git clone --depth 1 --branch $branch $url $directory
	cd $directory
	git submodule update --init --recursive
	echo "$0: finished cloning"
	exit 0
fi
