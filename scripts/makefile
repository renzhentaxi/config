cache_dir = build_cache
cache_dir_git = $(cache_dir)/git_repos
cache_dir_touch = $(cache_dir)/touch

VPATH = $(cache_dir_touch)


.PHONY: neovim 
neovim: always
	@$(MAKE) --no-print-directory make-neovim

touch_make_neovim = $(cache_dir_touch)/make-neovim
touch_update_neovim = $(cache_dir_touch)/update-neovim

git_neovim = $(cache_dir_git)/neovim

$(touch_make_neovim): $(touch_update_neovim) 
	sudo apt-get install ninja-build gettext libtool libtool-bin autoconf automake cmake g++ pkg-config unzip curl doxygen
	
	cd $(git_neovim) && sudo make && sudo make install
	
	touch $(touch_make_neovim)


$(touch_update_neovim):
	-./check-git.sh https://github.com/neovim/neovim $(git_neovim) && touch $(touch_update_neovim)
	test -f $(touch_update_neovim)|| touch $(touch_update_neovim)


.PHONY: clean_cache
clean_cache:
	rm -rf $(cache_dir)


.PHONY: always
always:
	mkdir -p $(cache_dir_git)
	mkdir -p $(cache_dir_touch)
