# needs to be imported by makefile

neovim_repo = $(cache_dir_git)/neovim
neovim_make = $(cache_dir_touch)/make-neovim
neovim_update = $(cache_dir_touch)/update-neovim


$(neovim_make):  $(neovim_update) 
	sudo apt-get install ninja-build gettext libtool libtool-bin autoconf automake cmake g++ pkg-config unzip curl doxygen
	
	cd $(neovim_repo) && sudo make && sudo make install
	
	touch $@


$(neovim_update): force
	if ./check-git.sh https://github.com/neovim/neovim $(neovim_repo); then touch $@; fi
	
	@# needed to handle cases where we clean the cache but not the git repo
	if [ ! -f $@ ]; then touch $@; fi 
