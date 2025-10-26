return
{
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {
    -- your configuration comes here
    -- or leave it empty to use the default settings
    -- refer to the configuration section below
        preset = "helix",
        -- ---@type number | fun(ctx: { keys: string, mode: string, plugin?: string }):number
        -- delay = function(ctx)
            -- return ctx.plugin and 0 or 200
        -- end,
    },
    keys = {
        {
            "<leader>hg",
            mode = { "n", "v", "x"},
            function()
                require("which-key").show({ global = true })
            end,
            desc = "global Keymaps",
        },
        {
            "<leader>hl",
            mode = { "n", "v", "x"},
            function()
                require("which-key").show({ global = false })
            end,
            desc = "local Keymaps",
        },
    },
}
