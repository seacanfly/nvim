return {
    "stevearc/conform.nvim",
    opts = {},
    config = function()
        require("conform").setup({
            formatters_by_ft = {
                lua = { "stylua" },
                c = { "clang-format" },
                -- Conform will run multiple formatters sequentially
                    -- You can use a function here to determine the formatters dynamically
                python = function(bufnr)
                  if require("conform").get_formatter_info("ruff_format", bufnr).available then
                    return { "ruff_format" }
                  else
                    return { "isort", "black" }
                  end
                end,
                -- You can customize some of the format options for the filetype (:help conform.format)
                rust = { "rustfmt" },
                -- Conform will run the first available formatter
                javascript = { "prettierd", "prettier", stop_after_first = true },
                sql = { "sqlfmt" },
                nix = { "nixpkgs-fmt" },
                default_format_opts = {
                    lsp_format = "fallback",
                },
            },
            formatters = {
                ['clang-format'] = {
                    -- 使用 args 数组来传递参数
                    args = { 
                        "--style=Microsoft" 
                    },
                    
                    -- 或者使用 prepend_args，在 conform 的默认参数前添加参数
                    -- prepend_args = { 
                        -- "--style=Microsoft" 
                    -- },
                },
            },
        })
    end,
    keys = {
        {
            "<leader>cf",
            function()
                require('conform').format()
            end,
            mode = {"n","v","x"}, 
            desc = "format code",
        },
    },
}

