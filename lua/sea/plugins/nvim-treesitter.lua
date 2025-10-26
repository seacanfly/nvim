return
{
    "nvim-treesitter/nvim-treesitter",
    branch = 'master', 
    lazy = false, 
    build = ":TSUpdate",
    config = function()
        ts = require("nvim-treesitter.configs")
        ts.setup({
            ensure_installed =
            {
                "python", "requirements", "toml", 
                "c", "cpp", "printf", "glsl", "hlsl", "llvm", "asm", "disassembly", 
                "yaml", "ini", "json", "csv", "tsv", "psv", "xml", "diff", "readline", 
                "cmake", "make", "nix", 
                "vim", "vimdoc", "query", "gap", 
                "powershell", "nu", "elvish", "tmux", "bash", "fish", 
                "markdown", "markdown_inline", "mermaid", "comment", "regex", "latex", 
                "html", "css", "javascript", "typescript", "jsdoc", "purescript", "elm", "tsx", "vue", "helm", "angular",     
                "haskell", "haskell_persistent", 
                "sql", 
                "gitignore", "gitcommit", "git_config", "git_rebase", "gitattributes", 
                "c_sharp", "swift", 
                "java", "javadoc", "kotlin", "groovy", "properties", 
                "gdscript", "gdshader", "godot_resource", 
                "ocaml", "ocaml_interface", "ocamllex", 
                "nginx", "dockerfile", "http", "vhdl", "go", "ql", "corn", "cuda", "graphql", "hack", 
                "rust", "scala", "racket", "commonlisp", "scheme", "prolog", "r", "clojure", "erlang", "dart", 
                "lua", "luadoc", "luap", 
                "php", "phpdoc", 
                "ssh_config", "fusion", "zig", "pascal", "fortran", "perl", "ruby", "elixir", "vhs", 
                
            },
            
            sync_install = false,
            auto_install = false,
            highlight = { enable = true, },
            indent = { enable = true },
            --autotage = { enable = true },
            
            incremental_selection = {
                enable = true,
                keymaps = {
                  init_selection = "<Enter>", -- set to `false` to disable one of the mappings
                  node_incremental = "<Enter>",
                  scope_incremental = false,
                  node_decremental = "<Backspace>",
                },
            }
        })
    end,
}
