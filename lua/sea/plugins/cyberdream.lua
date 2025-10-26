return 
{
    {
    	"scottmckendry/cyberdream.nvim",
    	lazy = false,
    	priority = 1000,
		config = function()
            require("cyberdream").setup({
                -- Enable transparent background
                transparent = true,
                -- Override a highlight group entirely using the built-in colour palette
                overrides = function(colors) -- NOTE: This function nullifies the `highlights` option
                    return {
                        -- 空白符显示
                        Whitespace    = { fg = "#FF0000", bg = "NONE", italic = false },
                        NonText       = { fg = "#af87ff", bg = "NONE", italic = false },
                        -- 行号
                        LineNr        = { fg = "#7fff7f", bg = "NONE", italic = false },
                        CursorLineNr  = { fg = "#00ff66", bg = "NONE", bold = true },
                        -- 选中文本
                        Visual        = { fg = "#00ff66", bg = "#903B9B", italic = false },
                        -- 光标
                        --Cursor        = { fg = "#00ff88", bg = "#00ff88", italic = false },
                        --lCursor       = { fg = "#000000", bg = "#00ff7f", italic = false },
                        -- 高亮列（colorcolumn）
                        ColorColumn   = { bg = "#3D3D3D" },
                        -- 光标行高亮
                        CursorLine    = { bg = "#355200" },
                    }
                end,

            });
            vim.cmd("colorscheme cyberdream");
        end
    },
}
