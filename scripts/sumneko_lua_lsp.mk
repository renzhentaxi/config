# needs to be imported by makefile

sumneko_lua_lsp_repo = $(cache_dir_git)/sumneko_lua_lsp
sumneko_lua_lsp_make = $(cache_dir_touch)/make-sumneko_lua_lsp
sumneko_lua_lsp_update = $(cache_dir_touch)/update-sumneko_lua_lsp
sumneko_lua_lsp_binary = /usr/local/bin/lua-language-server 

sumneko_lua_lsp_local_binary = $(sumneko_lua_lsp_repo)/bin/local_binary

sumneko_lua_lsp = $(sumneko_lua_lsp_binary)

$(sumneko_lua_lsp_make):  $(sumneko_lua_lsp_update) 
	sudo apt-get install ninja-build 
	cd $(sumneko_lua_lsp_repo)/3rd/luamake && ./compile/install.sh 
	cd $(sumneko_lua_lsp_repo) && ./3rd/luamake/luamake rebuild
	touch $@




$(sumneko_lua_lsp_update): force
	if ./check-git.sh https://github.com/sumneko/lua-language-server $(sumneko_lua_lsp_repo); then touch $@; fi
	
	@# needed to handle cases where we clean the cache but not the git repo
	if [ ! -f $@ ]; then touch $@; fi 


$(sumneko_lua_lsp_local_binary): $(sumneko_lua_lsp_make)
	touch $@
	echo '#!/bin/bash' > $@
	echo exec "$(sumneko_lua_lsp_repo)/bin/lua-language-server" "$$@"> $@
	chmod +x $@

$(sumneko_lua_lsp_binary): $(sumneko_lua_lsp_local_binary)
	sudo cp $(sumneko_lua_lsp_local_binary) $@
