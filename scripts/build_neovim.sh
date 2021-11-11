PrevDir=$(pwd)
DownloadDir=$HOME/downloads/git_repos
mkdir -p $DownloadDir
cd $DownloadDir 

echo cd $DownloadDir

if [ -d neovim ] 
then
	echo neovim repo exists, pulling 
	cd neovim
	git pull -q
	cd ../
else
	echo neovim repo does not exist, cloning
	git clone -q --depth 1 --branch master  --single-branch https://github.com/neovim/neovim
fi;


#debian deps
echo 'installing build deps'
sudo apt-get update -qq
sudo apt-get install -qq ninja-build gettext libtool libtool-bin autoconf automake cmake g++ pkg-config unzip curl doxygen

echo building neovim

cd neovim && make -j4
sudo make install
cd $PrevDir

