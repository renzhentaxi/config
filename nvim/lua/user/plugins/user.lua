return {
    {
        "ggandor/leap.nvim",
        keys = {
            { 's',  mode = { "n", "x", "o" }, desc = "leap forward to" },
            { 'S',  mode = { "n", "x", "o" }, desc = "leap backward to" },
            { 'gs', mode = { "n", "x", "o" }, desc = "leap from windows" },
        },
        config = function(_, opts)
            local leap = require('leap');
            for k, v in pairs(opts) do
                leap.opts[k] = v
            end
            require('leap').add_default_mappings(true);
        end
    }
}
