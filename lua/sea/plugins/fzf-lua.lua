return
{
    "ibhagwan/fzf-lua",
    -- optional for icon support
    -- dependencies = { "nvim-tree/nvim-web-devicons" },
    -- or if using mini.icons/mini.nvim
    dependencies = { "nvim-mini/mini.icons" },
    opts = {},
    keys = {
        {
            "<leader>ff",
            function() require('fzf-lua').files() end,
            desc = "Find Files"
        },
        {
            "<leader>fg",
            function() require('fzf-lua').live_grep() end,
            desc = "Find Live_Grep"
        },
        {
            --可以搜索其他所有,只要记住关键字,其他的fzf快捷键可删除
            "<leader><leader>",
            function() require('fzf-lua').builtin() end,
            desc = "Find Builtin"
        },
        {
            "<leader>fh",
            function() require('fzf-lua').helptags() end,
            desc = "Find Help"
        },
        {
            "<leader>fk",
            function() require('fzf-lua').keymaps() end,
            desc = "Find Keymaps"
        },
        {
            "<leader>fr",
            function() require('fzf-lua').resume() end,
            desc = "Find Resume"
        },
        {
            "<leader>fd",
            function() require('fzf-lua').diagnostics_document() end,
            desc = "Find Diagnostics_document"
        },
        {
            "<leader>fo",
            function() require('fzf-lua').oldfiles() end,
            desc = "Find Oldfiles"
        },
        {
            "<leader>fb",
            function() require('fzf-lua').buffers() end,
            desc = "Find Buffers"
        },
        {
            "<leader>fl",
            function() require('fzf-lua').lgrep_curbuf() end,
            desc = "live_grep current buffer(lgrep_curbuf)"
        },
    }
}
