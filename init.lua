-- 设置全局变量
vim.g.python3_host_prog = 'D:/bin_data/envs/python/Scripts/python.exe'
vim.g.loaded_perl_provider = 0
require("sea.core")
require("sea.lazy")
-- -- 获取 Neovim 启动参数
-- local args = vim.fn.argv()   -- 文件/目录参数
-- local argv = vim.v.argv      -- 完整 argv，包括 nvim 自身

-- -- 默认配置
-- local config = "sea"

-- -- 检查是否传了 -zero 参数
-- for _, v in ipairs(argv) do
    -- if v == "zero" then
        -- config = "zero"
        -- break
    -- end
-- end

-- -- 加载对应配置
-- if config == "sea" then
    -- require("sea.core")
    -- require("sea.lazy")
-- elseif config == "zero" then
    -- require("zero.core")
    -- require("zero.lazy")
-- else
    -- vim.notify("Unknown config: " .. config)
-- end

-- -- 默认配置
-- local default_config = "sea"
-- local lua_path = vim.fn.stdpath("config") .. "/lua"

-- -- 函数：检查目录是否存在
-- local function dir_exists(name)
    -- return vim.fn.isdirectory(lua_path .. "/" .. name) == 1
-- end

-- -- 1️. 优先检查环境变量 NVIM_CONFIG
-- local config = os.getenv("NVIM_CONFIG")

-- -- 2️. 如果没有环境变量，就检查命令行 -c "xxx"
-- if not config then
    -- local argv = vim.v.argv
    -- for _, v in ipairs(argv) do
        -- if v ~= "nvim.exe" and v ~= "." and v ~= vim.fn.getcwd() then
            -- local candidate = v:match("([^/\\]+)$")  -- 取最后一段
            -- if dir_exists(candidate) then
                -- config = candidate
                -- break
            -- end
        -- end
    -- end
-- end

-- -- 3️. 如果仍然没有指定，则使用默认配置
-- if not config then
    -- if dir_exists(default_config) then
        -- config = default_config
    -- else
        -- vim.notify("Default config '" .. default_config .. "' not found in lua/ !", vim.log.levels.ERROR)
        -- return
    -- end
-- end

-- -- 4️. 检查最终配置目录是否存在
-- if not dir_exists(config) then
    -- vim.notify("Specified config '" .. config .. "' does not exist in lua/ !", vim.log.levels.ERROR)
    -- return
-- end

-- -- 5️. 加载配置
-- local ok, err = pcall(function()
    -- require(config .. ".core")
    -- require(config .. ".lazy")
-- end)

-- if ok then
    -- vim.notify("Loaded Neovim config: " .. config)
-- else
    -- vim.notify("Failed to load config '" .. config .. "': " .. err, vim.log.levels.ERROR)
-- end