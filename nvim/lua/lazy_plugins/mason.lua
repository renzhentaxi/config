local packages_to_install = {
    -- rust
    "rust-analyzer", 
    -- typescript
    "typescript-language-server",
    -- lua
    "lua-language-server", "stylua"
}

local function install_package(package_name)
    vim.cmd("MasonInstall " .. package_name)
end

local function auto_install_packages(package_list)
    local mason = require("mason-registry")

    for _,name in ipairs(package_list) do
        if not mason.is_installed(name) then
            install_package(name)
        end
    end
end


return {
    {
        "williamboman/mason.nvim",
        config = function()
            local mason = require("mason").setup()
            auto_install_packages(packages_to_install)
        end
    }
}