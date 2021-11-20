versionURL=go1.17.3.linux-amd64.tar.gz
expectedSHA=550f9845451c0c94be679faf116291e7807a8d78b43149f9506c1b15eb89008c

if [ ! -f $versionURL ]
then
	curl -OL https://golang.org/dl/$versionURL
fi

fileSHA=$(sha256sum $versionURL)
if [ "$expectedSHA  $versionURL" != $fileSHA ]
then
	echo sha256 does not match
	return
fi

sudo rm -rf /usr/local/go && sudo tar -C /usr/local -xzf go1.17.3.linux-amd64.tar.gz

export PATH=$PATH:/usr/local/go/bin
