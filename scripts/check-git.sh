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

	# fetch current branch
	git fetch -q origin $(git branch --show-current)

	localHash=$(git rev-parse @)
	remoteHash=$(git rev-parse @{u})

	# compare hash
	if [ $localHash = $remoteHash ]; then
		exit 1
	else
		git pull -q
		exit 0
	fi

else
	git clone --depth 1 --branch $branch $url $directory
	exit 0
fi
