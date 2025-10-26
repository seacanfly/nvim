return {
    "kevinhwang91/nvim-ufo",
    dependencies = { "kevinhwang91/promise-async", "nvim-treesitter/nvim-treesitter" },
    event = "BufReadPost",
    config = function()
        -- Treesitter 折叠表达式
        vim.o.foldmethod = 'expr'
        vim.o.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
        vim.o.foldenable = true
        vim.o.foldlevel = 99

        -- UFO 设置
        require('ufo').setup({
            provider_selector = function(bufnr, filetype, buftype)
            -- treesitter 优先, 退化到 indent
                return { 'treesitter', 'indent' }
            end,
            fold_virt_text_handler = function(virtText, lnum, endLnum, width, truncate)
                -- 自定义虚拟折叠文本的显示方式
                local newVirtText = {}
                local suffix = (' ▼ %d lines... '):format(endLnum - lnum)
                local sufWidth = vim.fn.strdisplaywidth(suffix)
                local targetWidth = width - sufWidth
                local curWidth = 0
                for _, chunk in ipairs(virtText) do
                    local chunkText = chunk[1]
                    local chunkWidth = vim.fn.strdisplaywidth(chunkText)
                    if targetWidth > curWidth + chunkWidth then
                        table.insert(newVirtText, chunk)
                    else
                        chunkText = truncate(chunkText, targetWidth - curWidth)
                        table.insert(newVirtText, {chunkText, chunk[2]})
                        break
                    end
                    curWidth = curWidth + chunkWidth
                end
                table.insert(newVirtText, {suffix, "MoreMsg"})
                return newVirtText
            end,    -- 结束 fold_virt_text_handler function
        })          -- 结束 ufo.setup table
    end,            -- 结束 config function
}                   -- 结束 return table
