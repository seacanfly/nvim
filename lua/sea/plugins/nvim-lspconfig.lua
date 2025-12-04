return
{
    {
        -- Main LSP Configuration
        'neovim/nvim-lspconfig',
        dependencies = {
            -- Useful status updates for LSP.
            { 'j-hui/fidget.nvim', opts = {} },

            -- Allows extra capabilities provided by blink.cmp
            'saghen/blink.cmp',
        },
        config = function()
            -- If you're wondering about lsp vs treesitter, you can check out the wonderfully
            -- and elegantly composed help section, `:help lsp-vs-treesitter`

            --  This function gets run when an LSP attaches to a particular buffer.
            --    That is to say, every time a new file is opened that is associated with
            --    an lsp (for example, opening `main.rs` is associated with `rust_analyzer`) this
            --    function will be executed to configure the current buffer
            vim.api.nvim_create_autocmd('LspAttach', {
                group = vim.api.nvim_create_augroup('my.lsp', { clear = true }),
                callback = function(event)
                -- NOTE: Remember that Lua is a real programming language, and as such it is possible
                -- to define small helper and utility functions so you don't have to repeat yourself.
                --
                -- In this case, we create a function that lets us more easily define mappings specific
                -- for LSP related items. It sets the mode, buffer and description for us each time.
                local map = function(keys, func, desc, mode)
                    mode = mode or 'n'
                    vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
                end

                -- Rename the variable under your cursor.
                --  Most Language Servers support renaming across files, etc.
                -- map('grn', vim.lsp.buf.rename, '[R]e[n]ame')
                map('<leader>cr', vim.lsp.buf.rename, '[R]ename')

                -- Execute a code action, usually your cursor needs to be on top of an error
                -- or a suggestion from your LSP for this to activate.
                -- map('gra', vim.lsp.buf.code_action, '[G]oto Code [A]ction', { 'n', 'x' })
                map('<leader>ca', vim.lsp.buf.code_action, 'Code [A]ction', { 'n', 'x' })

                -- WARN: This is not Goto Definition, this is Goto Declaration.
                --  For example, in C this would take you to the header.
                -- map('grD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
                map('<leader>gD', vim.lsp.buf.declaration, 'Goto [D]eclaration')

                -- Jump to the definition of the word under your cursor.
                --  This is where a variable was first declared, or where a function is defined, etc.
                --  To jump back, press <C-t>.
                -- map('grd', require('telescope.builtin').lsp_definitions, '[G]oto [D]efinition')
                --map('<leader>gtd', require('telescope.builtin').lsp_definitions, 'Goto [D]efinition')
                map('<leader>gd', require('fzf-lua').lsp_definitions, 'Goto [D]efinition')

                -- Find references for the word under your cursor.
                -- map('grr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
                --map('<leader>gtr', require('telescope.builtin').lsp_references, 'Goto [R]eferences')
                map('<leader>gr', require('fzf-lua').lsp_references, 'Goto [R]eferences')

                -- Jump to the implementation of the word under your cursor.
                --  Useful when your language has ways of declaring types without an actual implementation.
                -- map('gri', require('telescope.builtin').lsp_implementations, '[G]oto [I]mplementation')
                --map('<leader>gti', require('telescope.builtin').lsp_implementations, 'Goto [I]mplementation')
                map('<leader>gi', require('fzf-lua').lsp_implementations, 'Goto [I]mplementation')

                -- Jump to the type of the word under your cursor.
                --  Useful when you're not sure what type a variable is and you want to see
                --  the definition of its *type*, not where it was *defined*.
                -- map('grt', require('telescope.builtin').lsp_type_definitions, '[G]oto [T]ype Definition')
                --map('<leader>gtt', require('telescope.builtin').lsp_type_definitions, 'Goto [T]ype Definition')
                map('<leader>ge', require('fzf-lua').lsp_typedefs, 'Goto Type D[e]finition')

                -- Fuzzy find all the symbols in your current document.
                --  Symbols are things like variables, functions, types, etc.
                -- map('gO', require('telescope.builtin').lsp_document_symbols, 'Open Document Symbols')
                --map('<leader>gts', require('telescope.builtin').lsp_document_symbols, 'Open Document Symbols')
                map('<leader>gs', require('fzf-lua').lsp_document_symbols, 'Open Document Symbols')

                -- Fuzzy find all the symbols in your current workspace.
                --  Similar to document symbols, except searches over your entire project.
                -- map('gW', require('telescope.builtin').lsp_dynamic_workspace_symbols, 'Open Workspace Symbols')
                --map('<leader>gtS', require('telescope.builtin').lsp_dynamic_workspace_symbols, 'Open Workspace Symbols')
                map('<leader>gS', require('fzf-lua').lsp_live_workspace_symbols, 'Open Workspace Symbols')

                -- This function resolves a difference between neovim nightly (version 0.11) and stable (version 0.10)
                ---@param client vim.lsp.Client
                ---@param method vim.lsp.protocol.Method
                ---@param bufnr? integer some lsp support methods only in specific files
                ---@return boolean
                local function client_supports_method(client, method, bufnr)
                        return client:supports_method(method, bufnr)
                end

                -- The following two autocommands are used to highlight references of the
                -- word under your cursor when your cursor rests there for a little while.
                --    See `:help CursorHold` for information about when this is executed
                --
                -- When you move your cursor, the highlights will be cleared (the second autocommand).
                local client = vim.lsp.get_client_by_id(event.data.client_id)
                if client and client_supports_method(client, vim.lsp.protocol.Methods.textDocument_documentHighlight, event.buf) then
                    local highlight_augroup = vim.api.nvim_create_augroup('kickstart-lsp-highlight', { clear = false })
                    vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
                        buffer = event.buf,
                        group = highlight_augroup,
                        callback = vim.lsp.buf.document_highlight,
                    })

                    vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
                        buffer = event.buf,
                        group = highlight_augroup,
                        callback = vim.lsp.buf.clear_references,
                    })

                    vim.api.nvim_create_autocmd('LspDetach', {
                        group = vim.api.nvim_create_augroup('kickstart-lsp-detach', { clear = true }),
                        callback = function(event2)
                            vim.lsp.buf.clear_references()
                            vim.api.nvim_clear_autocmds { group = 'kickstart-lsp-highlight', buffer = event2.buf }
                        end,
                    })
                end

                -- The following code creates a keymap to toggle inlay hints in your
                -- code, if the language server you are using supports them
                --
                -- This may be unwanted, since they displace some of your code
                if client and client_supports_method(client, vim.lsp.protocol.Methods.textDocument_inlayHint, event.buf) then
                    map('<leader>lh', function()
                    vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = event.buf })
                    end, 'Toggle Inlay [H]ints')
                end
                end,
            })

            -- Diagnostic Config
            -- See :help vim.diagnostic.Opts
            vim.diagnostic.config {
                severity_sort = true,
                float = { border = 'rounded', source = 'if_many' },
                underline = { severity = vim.diagnostic.severity.ERROR },
                signs = vim.g.have_nerd_font and {
                    text = {
                        [vim.diagnostic.severity.ERROR] = '✘',--'󰅚 ',
                        [vim.diagnostic.severity.WARN] = '▲',--'󰀪 ',
                        [vim.diagnostic.severity.INFO] = '⚑',--'󰋽 ',
                        [vim.diagnostic.severity.HINT] = '»',--'󰌶 ',
                    },
                } or {},
                virtual_text = {
                    source = 'if_many',
                    spacing = 2,
                    format = function(diagnostic)
                        local diagnostic_message = {
                        [vim.diagnostic.severity.ERROR] = diagnostic.message,
                        [vim.diagnostic.severity.WARN] = diagnostic.message,
                        [vim.diagnostic.severity.INFO] = diagnostic.message,
                        [vim.diagnostic.severity.HINT] = diagnostic.message,
                        }
                        return diagnostic_message[diagnostic.severity]
                    end,
                },
            }

            -- LSP servers and clients are able to communicate to each other what features they support.
            --  By default, Neovim doesn't support everything that is in the LSP specification.
            --  When you add blink.cmp, luasnip, etc. Neovim now has *more* capabilities.
            --  So, we create new capabilities with blink.cmp, and then broadcast that to the servers.
            local vim_capabilities = vim.lsp.protocol.make_client_capabilities()
            local caps = require('blink.cmp').get_lsp_capabilities(vim_capabilities)

            vim.lsp.config['luals'] = {
                cmd = { 'lua-language-server' },
                filetypes = { 'lua' },
                root_markers = { { '.luarc.json', '.luarc.jsonc' }, '.git' },
                capabilities = caps,
                settings = {
                    Lua = {
                        runtime = { version = 'LuaJIT' },
                        diagnostics = { globals = { 'vim' } },
                        workspace = {
                            checkThirdParty = false,
                            library = vim.api.nvim_get_runtime_file('', true),
                        },
                        telemetry = { enable = false },
                    },
                },
            }
            
            vim.lsp.config['tailwindcss-language-server'] = {
                cmd = { 'tailwindcss-language-server', '--stdio' },
                filetypes = { 'html', 'css', 'scss', 'javascript', 'javascriptreact', 'typescript', 'typescriptreact', 'vue', 'svelte' },
                root_markers = { 'package.json', 'tailwind.config.js', 'tailwind.config.cjs', '.git' },
                capabilities = caps,
            }
            -- vim.lsp.config['cssls'] = {
                -- cmd = { 'vscode-css-language-server', '--stdio' },
                -- filetypes = { 'css', 'scss', 'less' },
                -- root_markers = { 'package.json', '.git' },
                -- capabilities = caps,
                -- settings = {
                    -- css = { validate = true },
                    -- scss = { validate = true },
                    -- less = { validate = true },
                -- },
            -- }

            -- vim.lsp.config['phpls'] = {
                -- cmd = { 'intelephense', '--stdio' },
                -- filetypes = { 'php' },
                -- root_markers = { 'composer.json', '.git' },
                -- capabilities = caps,
                -- settings = {
                    -- intelephense = {
                        -- files = {
                            -- maxSize = 5000000, -- default 5MB
                        -- },
                    -- },
                -- },
            -- }

            vim.lsp.config['ts_ls'] = {
                cmd = { 'typescript-language-server', '--stdio' },
                filetypes = {
                    'javascript', 'javascriptreact', 'javascript.jsx',
                    'typescript', 'typescriptreact', 'typescript.tsx',
                },
                root_markers = { 'package.json', 'tsconfig.json', 'jsconfig.json', '.git' },
                capabilities = caps,
                settings = {
                    completions = {
                        completeFunctionCalls = true,
                    },
                },
            }

            --Nix LSP (nil)
            vim.lsp.config['nil_ls'] = {
                cmd = { 'nil' },
                filetypes = { 'nix' },
                root_markers = { 'flake.nix', 'default.nix', '.git' },
                capabilities = caps,
                settings = {
                    ['nil'] = {
                        formatting = {
                            command = { "nixpkgs-fmt" } -- or "alejandra" if you prefer
                        }
                    }
                }
            }
            
            vim.lsp.config['pyright'] = {
                filetypes = { 'python' },
                root_markers = { 'pyproject.toml', 'setup.py', 'setup.cfg', 'requirements.txt', 'poetry.lock', '.git' },
                capabilities = caps,
            }
            
            vim.lsp.config['clangd'] = {
                cmd = { 'clangd' },
                filetypes = { 'c', 'cpp', 'cc', 'cxx', 'h', 'hpp' },
                root_markers = { 'compile_commands.json', 'compile_flags.txt', '.git' },
                capabilities = caps,
            }
        end,
        vim.lsp.enable('clangd'),
        vim.lsp.enable('luals'),
        vim.lsp.enable('cssls'),
        vim.lsp.enable('ts_ls'),
        --vim.lsp.enable('phpls'),
        vim.lsp.enable('nil_ls'),
        vim.lsp.enable('pyright'),
        vim.lsp.enable('tailwindcss-language-server'),
    },
}
