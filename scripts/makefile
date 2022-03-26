cache_dir = build_cache
cache_dir_git = $(cache_dir)/git_repos
cache_dir_touch = $(cache_dir)/touch

touch_make_neovim = $(cache_dir_touch)/make-neovim
touch_update_neovim = $(cache_dir_touch)/update-neovim
git_neovim = $(cache_dir_git)/neovim

.PHONY: neovim 
neovim: | $(cache_dir_touch) $(cache_dir_git)
	@$(MAKE) --no-print-directory $(touch_make_neovim)


$(touch_make_neovim):  $(touch_update_neovim) 
	sudo apt-get install ninja-build gettext libtool libtool-bin autoconf automake cmake g++ pkg-config unzip curl doxygen
	
	cd $(git_neovim) && sudo make && sudo make install
	touch $(touch_make_neovim)


$(touch_update_neovim): force
	if ./check-git.sh https://github.com/neovim/neovim $(git_neovim); then touch $@; fi
	
	@# needed to handle cases where we clean the cache but not the git repo
	if [ ! -f $@ ]; then touch $@; fi 


.PHONY: force
force: ;

.PHONY: clean_cache
clean_cache:
	rm -rf $(cache_dir)




$(cache_dir_git):
	mkdir $(cache_dir_git)

$(cache_dir_touch):
	mkdir $(cache_dir_touch)

