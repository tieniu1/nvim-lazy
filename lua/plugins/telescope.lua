local telescopeConfig = require("telescope.config")

-- 克隆默认的望远镜配置
local vimgrep_arguments = { unpack(telescopeConfig.values.vimgrep_arguments) }

-- 搜索隐藏/点文件
table.insert(vimgrep_arguments, "--hidden")

return {
  {
    "telescope.nvim",
    opts = {
      defaults = {
        vimgrep_arguments = vimgrep_arguments,
      },
    },
  },
}
