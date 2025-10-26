return {
    "saghen/blink.cmp",
    -- optional: provides snippets for the snippet source
    dependencies = { 
        "rafamadriz/friendly-snippets",
        "moyiz/blink-emoji.nvim",
    },

    -- use a release tag to download pre-built binaries
    version = "1.*",
    -- AND/OR build from source, requires nightly: https://rust-lang.github.io/rustup/concepts/channels.html#working-with-nightly-rust
    -- build = 'cargo build --release',
    -- If you use nix, you can build from source using latest nightly rust with:
    -- build = 'nix run .#build-plugin',

    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    opts = {
        -- 'default' (recommended) for mappings similar to built-in completions (C-y to accept)
        -- 'super-tab' for mappings similar to vscode (tab to accept)
        -- 'enter' for enter to accept
        -- 'none' for no mappings
        --
        -- All presets have the following mappings:
        -- C-space: Open menu or open docs if already open
        -- C-n/C-p or Up/Down: Select next/previous item
        -- C-e: Hide menu
        -- C-k: Toggle signature help (if signature.enabled = true)
        --
        -- See :h blink-cmp-config-keymap for defining your own keymap
        keymap = { preset = "default" },

        appearance = {
            -- 'mono' (default) for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
            -- Adjusts spacing to ensure icons are aligned
            nerd_font_variant = "mono",
        },

        -- (Default) Only show the documentation popup when manually triggered
        completion = { documentation = { auto_show = true } },
        signature = { enabled = true },
        -- Default list of enabled providers defined so that you can extend it
        -- elsewhere in your config, without redefining it, due to `opts_extend`
        sources = {
            default = { "lsp", "path", "snippets", "buffer", "emoji" },
            providers = {
                emoji = {
                    module = "blink-emoji",
                    name = "Emoji",
                    score_offset = 15, -- Tune by preference
                    opts = {
                        insert = true, -- Insert emoji (default) or complete its name
                        ---@type string|table|fun():table
                        trigger = function()
                            return { ":" }
                        end,
                    },
                    should_show_items = function()
                        -- 默认配置
                        -- return vim.tbl_contains(
                            -- -- Enable emoji completion only for git commits and markdown.
                            -- -- By default, enabled for all file-types.
                            -- { "gitcommit", "markdown" },
                            -- vim.o.filetype
                        -- )
                        
                        -- 让 blink-emoji 在固定文件类型,或在代码的字符串或注释中启用
                        
                        -- 允许的文件类型
                        local ft = vim.bo.filetype
                        local allowed_filetypes = { "gitcommit", "markdown" }

                        -- 如果是允许的文件类型，直接启用
                        if vim.tbl_contains(allowed_filetypes, ft) then
                            return true
                        end

                        -- 尝试使用 Treesitter 检测注释或字符串
                        local ok, ts = pcall(require, "vim.treesitter")
                        
                        if ok and ts.get_parser then
                            local parser = ts.get_parser(0)
                            if parser then
                                local tree = parser:parse()[1]
                                local root = tree and tree:root()
                                if root then
                                    local row, col = unpack(vim.api.nvim_win_get_cursor(0))
                                    row = row - 1
                                    -- ⚠️ 调整列到前一个字符（避免在注释结尾无法检测）
                                    if col > 0 then col = col - 1 end

                                    local node = root:named_descendant_for_range(row, col, row, col)
                                    while node do
                                        local t = node:type()
                                        if t:match("comment")
                                            or t:match("comment_content")
                                            or t:match("string")
                                            or t:match("doc")
                                            or t:match("block_comment")
                                            or t:match("line_comment")
                                        then
                                            return true
                                        end
                                        node = node:parent()
                                    end
                                end
                            end
                        end


                        -- fallback: syntax 检查
                        local syn_id = vim.fn.synID(vim.fn.line('.'), vim.fn.col('.') - 1, 1)
                        local syn_name = vim.fn.synIDattr(syn_id, 'name')
                        if syn_name:match("Comment") or syn_name:match("String") or syn_name:match("Doc") then
                            return true
                        end

                        return false
                    end,
                }
            }
        },

        -- (Default) Rust fuzzy matcher for typo resistance and significantly better performance
        -- You may use a lua implementation instead by using `implementation = "lua"` or fallback to the lua implementation,
        -- when the Rust fuzzy matcher is not available, by using `implementation = "prefer_rust"`
        --
        -- See the fuzzy documentation for more information
        fuzzy = { implementation = "prefer_rust_with_warning" },
    },
    opts_extend = { "sources.default" },
}

