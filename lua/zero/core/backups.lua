-- 获取项目根目录（优先 git 根）
local function get_project_root()
  local cwd = vim.fn.getcwd()
  local git_root = vim.fn.systemlist("git -C " .. cwd .. " rev-parse --show-toplevel")[1]
  if vim.v.shell_error == 0 and git_root and #git_root > 0 then
    return git_root
  else
    return cwd
  end
end

-- 创建缓存路径（每个项目一个）
local function setup_project_local_cache()
  local project_root = get_project_root()
  local project_name = vim.fn.fnamemodify(project_root, ":t")
  local base_cache = vim.fn.stdpath("cache") -- ~/.cache/nvim on Linux/macOS

  local undo_dir = base_cache .. "/undo/" .. project_name
  local swap_dir = base_cache .. "/swap/" .. project_name
  local backup_dir = base_cache .. "/backup/" .. project_name

  vim.fn.mkdir(undo_dir, "p")
  vim.fn.mkdir(swap_dir, "p")
  vim.fn.mkdir(backup_dir, "p")

  vim.opt.undodir = undo_dir
  vim.opt.backupdir = backup_dir
  vim.opt.directory = swap_dir

  vim.opt.undofile = true
  vim.opt.backup = true
  vim.opt.swapfile = true
end

-- 每次打开 buffer 时触发
vim.api.nvim_create_autocmd("BufReadPre", {
  callback = setup_project_local_cache
})

