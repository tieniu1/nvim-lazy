return {
  -- eslint
  { import = "lazyvim.plugins.extras.linting.eslint" },
  -- prettier
  { import = "lazyvim.plugins.extras.formatting.prettier" },
  -- 开启vscode支持
  { import = "lazyvim.plugins.extras.vscode" },
  -- telescope
  -- { import = "lazyvim.plugins.extras.editor.telescope" },
  -- fzf
  { import = "lazyvim.plugins.extras.editor.fzf" },
  -- yanky
  { import = "lazyvim.plugins.extras.coding.yanky" },
  -- codeium
  -- { import = "lazyvim.plugins.extras.ai.codeium" },
  -- diff
  { import = "lazyvim.plugins.extras.editor.mini-diff" },
  -- markdown
  { import = "lazyvim.plugins.extras.lang.markdown" },
  {
    -- TODO 高亮注释
    "folke/todo-comments.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {
      highlight = {

        pattern = [[.*<(KEYWORDS)\s*]], -- 匹配，而不带额外的冒号。您可能会得到误报
      },
      search = {
        pattern = [[\b(KEYWORDS)\b]], -- 匹配，而不带额外的冒号。您可能会得到误报
      },
    },
  },
  -- { -- AI插件支持deepseek
  --   "Kurama622/llm.nvim",
  --   dependencies = { "nvim-lua/plenary.nvim", "MunifTanjim/nui.nvim" },
  --   cmd = { "LLMSesionToggle", "LLMSelectedTextHandler" },
  --   config = function()
  --     require("llm").setup({
  --       url = "https://api.deepseek.com/v1/chat/completions",
  --       model = "deepseek-chat",
  --       api_type = "openai",
  --       max_tokens = 4096,
  --     })
  --   end,
  --   keys = {
  --     { "<leader>ac", mode = "n", "<cmd>LLMSessionToggle<cr>" },
  --   },
  -- },
  --
  --#AI插件支持
  {
    "yetone/avante.nvim",
    event = "VeryLazy",
    lazy = false,
    version = false, -- 如果你想要始终获取最新的更改，请设置这个
    opts = {
      provider = "openai",
      openai = {
        -- linux.do 的配置
        -- endpoint = "https://api.oaipro.com/v1",
        -- model = "claude-3-5-sonnet-20241022",

        -- deepseek
        endpoint = "https://api.deepseek.com/v1",
        -- model = "deepseek-chat",
        model = "deepseek-coder",

        timeout = 30000, -- Timeout in milliseconds
        temperature = 0,
        max_tokens = 4096,
      },
      -- 在这里添加任何选项
    },
    -- 如果你想从源代码构建，使用 `make BUILD_FROM_SOURCE=true`
    build = "make",
    -- build = "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false" -- Windows系统使用这个
    dependencies = {
      "stevearc/dressing.nvim",
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
      --- 以下依赖是可选的
      "hrsh7th/nvim-cmp", -- 用于avante命令和提及的自动补全
      "nvim-tree/nvim-web-devicons", -- 或使用 echasnovski/mini.icons
      "zbirenbaum/copilot.lua", -- 当 providers='copilot' 时需要
      {
        -- 支持图片粘贴
        "HakonHarnes/img-clip.nvim",
        event = "VeryLazy",
        opts = {
          -- 推荐设置
          default = {
            embed_image_as_base64 = false,
            prompt_for_file_name = false,
            drag_and_drop = {
              insert_mode = true,
            },
            -- Windows用户必需
            use_absolute_path = true,
          },
        },
      },
      -- {
      --   -- 如果你设置了lazy=true，确保正确设置这个
      --   "MeanderingProgrammer/render-markdown.nvim",
      --   opts = {
      --     file_types = { "markdown", "Avante" },
      --   },
      --   ft = { "markdown", "Avante" },
      -- },
    },
  },
  {
    "robitx/gp.nvim",
    config = function()
      local conf = {
        providers = {
          openai = {
            -- 直接替换为你的兼容端点
            endpoint = "https://api.deepseek.com/v1/chat/completions",
            -- 你的 API key
            secret = os.getenv("OPENAI_API_KEY"),
          },
        },
        default_command_agent = "deepseek-chat",
        default_chat_agent = "deepseek-chat",
        agents = {
          {
            name = "deepseek-chat", -- 你可以自定义名字
            provider = "openai",
            chat = true, -- 用于聊天
            command = true, -- 用于命令
            model = { model = "deepseek-chat" }, -- 在这里指定模型
            system_prompt = "You are a helpful AI assistant.",
          },
        },
      }
      require("gp").setup(conf)

      require("which-key").add({
        -- VISUAL 模式映射
        {
          mode = { "v" },
          nowait = true,
          remap = false,
          -- { "<C-g><C-t>", ":<C-u>'<,'>GpChatNew tabnew<cr>", desc = "新建聊天（新标签页）" },
          -- { "<C-g><C-x>", ":<C-u>'<,'>GpChatNew split<cr>", desc = "新建聊天（水平分割）" },
          -- { "<C-g>c", ":<C-u>'<,'>GpChatNew<cr>", desc = "新建聊天" },
          { "<C-g>a", ":<C-u>'<,'>GpAppend<cr>", desc = "在选中内容后追加" },
          { "<C-g>b", ":<C-u>'<,'>GpPrepend<cr>", desc = "在选中内容前追加" },
          { "<C-g>c", ":<C-u>'<,'>GpChatNew vsplit<cr>", desc = "新建聊天（垂直分割）" },
          { "<C-g>g", group = "生成到新位置.." },
          { "<C-g>gp", ":<C-u>'<,'>GpPopup<cr>", desc = "生成到弹出窗口" },
          { "<C-g>gv", ":<C-u>'<,'>GpVnew<cr>", desc = "生成到垂直分割" },
          { "<C-g>i", ":<C-u>'<,'>GpImplement<cr>", desc = "实现选中内容" },
          { "<C-g>n", "<cmd>GpNextAgent<cr>", desc = "下一个 Agent" },
          { "<C-g>p", ":<C-u>'<,'>GpChatPaste<cr>", desc = "粘贴到聊天" },
          { "<C-g>r", ":<C-u>'<,'>GpRewrite<cr>", desc = "重写选中内容" },
          { "<C-g>s", "<cmd>GpStop<cr>", desc = "停止生成" },
          { "<C-g>t", ":<C-u>'<,'>GpChatToggle<cr>", desc = "切换聊天窗口" },
          -- { "<C-g>gt", ":<C-u>'<,'>GpTabnew<cr>", desc = "生成到新标签页" },
          -- { "<C-g>ge", ":<C-u>'<,'>GpEnew<cr>", desc = "生成到新缓冲区" },
          -- { "<C-g>gn", ":<C-u>'<,'>GpNew<cr>", desc = "生成到新窗口" },
        },

        -- NORMAL 模式映射
        {
          mode = { "n" },
          nowait = true,
          remap = false,
          -- { "<C-g><C-t>", "<cmd>GpChatNew tabnew<cr>", desc = "新建聊天（新标签页）" },
          -- { "<C-g><C-x>", "<cmd>GpChatNew split<cr>", desc = "新建聊天（水平分割）" },
          -- { "<C-g>c", "<cmd>GpChatNew<cr>", desc = "新建聊天" },
          { "<C-g>a", "<cmd>GpAppend<cr>", desc = "在当前位置后追加" },
          { "<C-g>b", "<cmd>GpPrepend<cr>", desc = "在当前位置前追加" },
          { "<C-g>c", "<cmd>GpChatNew vsplit<cr>", desc = "新建聊天（垂直分割）" },
          { "<C-g>f", "<cmd>GpChatFinder<cr>", desc = "聊天查找器" },
          { "<C-g>g", group = "生成到新位置.." },
          { "<C-g>gp", "<cmd>GpPopup<cr>", desc = "生成到弹出窗口" },
          { "<C-g>gv", "<cmd>GpVnew<cr>", desc = "生成到垂直分割" },
          { "<C-g>n", "<cmd>GpNextAgent<cr>", desc = "下一个 Agent" },
          { "<C-g>r", "<cmd>GpRewrite<cr>", desc = "行内重写" },
          { "<C-g>s", "<cmd>GpStop<cr>", desc = "停止生成" },
          { "<C-g>t", "<cmd>GpChatToggle<cr>", desc = "切换聊天窗口" },
          -- { "<C-g>ge", "<cmd>GpEnew<cr>", desc = "生成到新缓冲区" },
          -- { "<C-g>gn", "<cmd>GpNew<cr>", desc = "生成到新窗口" },
          -- { "<C-g>gt", "<cmd>GpTabnew<cr>", desc = "生成到新标签页" },
        },

        -- INSERT 模式映射
        {
          mode = { "i" },
          nowait = true,
          remap = false,
          -- { "<C-g><C-t>", "<cmd>GpChatNew tabnew<cr>", desc = "新建聊天（新标签页）" },
          -- { "<C-g><C-x>", "<cmd>GpChatNew split<cr>", desc = "新建聊天（水平分割）" },
          -- { "<C-g>c", "<cmd>GpChatNew<cr>", desc = "新建聊天" },
          { "<C-g>a", "<cmd>GpAppend<cr>", desc = "在当前位置后追加" },
          { "<C-g>b", "<cmd>GpPrepend<cr>", desc = "在当前位置前追加" },
          { "<C-g>c", "<cmd>GpChatNew vsplit<cr>", desc = "新建聊天（垂直分割）" },
          { "<C-g>f", "<cmd>GpChatFinder<cr>", desc = "聊天查找器" },
          { "<C-g>g", group = "生成到新位置.." },
          { "<C-g>gp", "<cmd>GpPopup<cr>", desc = "生成到弹出窗口" },
          { "<C-g>gv", "<cmd>GpVnew<cr>", desc = "生成到垂直分割" },
          { "<C-g>n", "<cmd>GpNextAgent<cr>", desc = "下一个 Agent" },
          { "<C-g>r", "<cmd>GpRewrite<cr>", desc = "行内重写" },
          { "<C-g>s", "<cmd>GpStop<cr>", desc = "停止生成" },
          { "<C-g>t", "<cmd>GpChatToggle<cr>", desc = "切换聊天窗口" },
          -- { "<C-g>ge", "<cmd>GpEnew<cr>", desc = "生成到新缓冲区" },
          -- { "<C-g>gn", "<cmd>GpNew<cr>", desc = "生成到新窗口" },
          -- { "<C-g>gt", "<cmd>GpTabnew<cr>", desc = "生成到新标签页" },
        },
      })
    end,
  },
}
