greenText=`tput setaf 2`
resetText=`tput sgr0`
log() {
	echo "${greenText}$1${resetText}"
}

# prerequisites 
log "installing prerequsites"
sudo apt-get -q update
sudo apt-get -q -y install ca-certificates curl gnupg lsb-release

# docker GPG key
log "adding GPG key to apt sources"

curl -fsSL https://download.docker.com/linux/debian/gpg | sudo gpg --dearmor --yes -o /usr/share/keyrings/docker-archive-keyring.gpg

# add docker repo to apt
log "adding docker repo"

echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/debian $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

sudo apt-get update

# install docker
log "installing docker"
sudo apt-get -y -q install docker-ce docker-ce-cli containerd.io
