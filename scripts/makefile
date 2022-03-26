cache_dir = build_cache
cache_dir_git = $(cache_dir)/git_repos
cache_dir_touch = $(cache_dir)/touch




include ./neovim.mk

.DEFAULT_GOAL: all
.PHONY: all
all: $(neovim_make) | $(cache_dir_touch) $(cache_dir_git);



.PHONY: force
force: ;



# create the cache directory
$(cache_dir_git):
	mkdir $(cache_dir_git)

$(cache_dir_touch):
	mkdir $(cache_dir_touch)

