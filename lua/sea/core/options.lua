-- 启用鼠标支持（在所有模式下都可以使用鼠标）
vim.opt.mouse = "a"

-- 设置光标样式为空字符串：在不同模式下保持统一（通常是方块）
--vim.opt.guicursor = ""
-- 不同模式下的光标形状：
--  n-v-c 模式下：方块 (block)
--  i-ci-ve 模式下：竖线 (ver25)，高度为 25%
--  r-cr-o 模式下：水平线 (hor20)，高度为 20%
-- vim.opt.guicursor = "n-v-c:block,i-ci-ve:ver25,r-cr-o:hor20"

-- 启用真彩色支持（让配色方案支持 24-bit 色彩）
vim.opt.termguicolors = true

-- 启用nerd font的支持
vim.g.have_nerd_font = true

-- 行号设置
vim.opt.number = true   -- 显示行号
vim.opt.relativenumber = true   -- 显示相对行号（方便计算移动距离）

-- Tab与缩进设定
vim.opt.expandtab = true    -- convert tabs to spaces

vim.opt.tabstop = 4         -- 设置 Tab 的视觉宽度为 4 个空格
vim.opt.shiftwidth = 4      -- 自动缩进时每一级缩进为 4 个空格
vim.opt.softtabstop = 4     -- 在插入模式下按 Tab 键插入 4 个空格

vim.opt.smarttab = true         -- 智能 Tab：在行首使用 Tab 时考虑 shiftwidth
vim.opt.autoindent = true       -- 启用自动缩进（继承上一行的缩进）
vim.opt.smartindent =true       -- 启用智能缩进（根据语法结构自动调整缩进）
vim.opt.breakindent = true      -- 启用断行缩进（长行换行后保持缩进）

-- 设置滚动时光标距离窗口顶部/底部的最小行数
vim.opt.scrolloff = 8

-- 左侧始终显示标志列（例如 git 标记、诊断信息）
vim.opt.signcolumn = "yes"

-- 光标移动或输入后更新延迟（影响 LSP、诊断刷新速度）
vim.opt.updatetime = 300

-- 设置警告列（在第 80、100、120 列显示竖线，提醒代码长度）
vim.opt.colorcolumn = "80,100,120"

-- 高亮显示当前光标所在行
vim.opt.cursorline = true

-- Sets how neovim will display certain whitespace characters in the editor.
--  See `:help 'list'`
--  and `:help 'listchars'`
-- 启用空白字符可视化
vim.opt.list = true
-- 设置要显示的特殊空白字符
vim.opt.listchars = {
--  space = "·",   -- 普通空格
  tab = "→ ",    -- 制表符（Tab）
  trail = "•",   -- 行尾空格
--  eol = "⏎",     -- 换行
  nbsp = "␣"     -- 不间断空格（non-breaking space）
}

-- 将系统剪贴板加入 Neovim 的复制/粘贴操作
-- 使得 `y`, `p`, `d` 等命令可以直接与系统剪贴板互通
vim.opt.clipboard:append("unnamedplus")

-- 诊断信息跳转,不用开启,只要没有去覆盖vim.diagnostic.goto_next(),vim.diagnostic.goto_prev()命令快捷键,nvim默认会设置这个.
-- vim.keymap.set('n', ']d', function() vim.diagnostic.goto_next() end, { desc = "next diagnostic" })
-- vim.keymap.set('n', '[d', function() vim.diagnostic.goto_prev() end, { desc = "prev diagnostic" })







