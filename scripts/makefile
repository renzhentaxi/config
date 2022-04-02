cache_dir = ~/.build_cache
cache_dir_git = $(cache_dir)/git_repos
cache_dir_touch = $(cache_dir)/touch



start: all

include ./neovim.mk ./node.mk ./sumneko_lua_lsp.mk

targets = $(neovim_make) $(sumneko_lua_lsp) 

.PHONY: all
all: | $(cache_dir_touch) $(cache_dir_git);
	$(MAKE) $(targets)


.PHONY: force
force: ;



# create the cache directory
$(cache_dir_git):
	mkdir $(cache_dir_git)

$(cache_dir_touch):
	mkdir $(cache_dir_touch)



.PHONY: clean_cache
clean_cache:
	rm -rf $(cache_dir)

