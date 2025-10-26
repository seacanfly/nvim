-- 设置 leader 键
vim.g.mapleader = " "           -- 设置全局 leader 键为空格（常用于自定义快捷键，如 <leader>f 保存文件等）
vim.g.maplocalleader = " "      -- 设置局部 leader 键为空格（用于特定插件或 buffer 局部映射）


-- 在visaul模式下,按[J/K]向[下/上]移动选中的行.silent = true:不在命令行显示执行命令,noremap = true:禁止递归映射
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move selected lines down", silent = true, noremap = true })
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move selected lines up", silent = true, noremap = true })

-- 在普通模式下按 "gl" 打开当前行的 LSP 诊断浮动窗口, 可显示错误、警告或提示的详细信息
vim.keymap.set("n", "gl", function() vim.diagnostic.open_float() end, {desc = "open diagnostic"})
