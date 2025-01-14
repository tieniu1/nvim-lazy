-- 自动命令在 VeryLazy 事件上自动加载
-- 默认的自动命令始终设置：https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- 在此添加任何额外的自动命令

-- markdown 文件关闭拼写检查
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "markdown" },
  callback = function()
    vim.opt_local.spell = false
  end,
})

-- 自动保存文件修改到项目根目录的.history文件夹
-- vim.api.nvim_create_autocmd("BufWritePost", {
--   pattern = "*",
--   callback = function()
--     -- 获取当前文件的完整路径
--     local file_path = vim.fn.expand("%:p") -- 完整路径
--
--     -- 获取项目根目录
--     local project_root = vim.fn.getcwd() -- 项目根目录
--
--     -- 计算文件相对于项目根目录的路径
--     local relative_path = vim.fn.fnamemodify(file_path, ":.") -- 获取相对于当前目录的路径
--
--     -- 构建 .history 目录路径，使用相对路径的目录部分
--     local history_dir = project_root .. "/.history/" .. relative_path:gsub("/[^/]+$", "") -- 去掉文件名部分，只保留目录
--
--     -- 获取当前文件名
--     local file_name = vim.fn.expand("%:t") -- 文件名
--
--     -- 生成当前时间戳
--     local timestamp = os.date("%Y%m%d_%H%M%S")
--
--     -- 构建历史文件的完整路径
--     local base_name = file_name:gsub("%..+$", "") -- 去掉文件扩展名
--     local ext = file_name:match("%.(.+)$") or "" -- 获取文件扩展名
--     local history_file = history_dir .. "/" .. base_name .. "_" .. timestamp .. (ext ~= "" and ("." .. ext) or "")
--
--     -- 创建历史目录（如果不存在）
--     vim.fn.mkdir(history_dir, "p")
--
--     -- 复制当前文件到历史目录
--     vim.fn.system("cp " .. file_path .. " " .. history_file)
--   end,
-- })
