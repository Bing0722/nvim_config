return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      --   diagnostics = {
      --     virtual_text = false, -- 禁用虚拟文本显示
      --     -- signs = true, -- 保持标志显示（侧边的符号）
      --     underline = false, -- 保持下划线显示
      --     update_in_insert = false, -- 插入模式不更新诊断信息
      --     -- virtual_text = {
      --     --   spacing = 4,
      --     --   source = "if_many",
      --     --   prefix = "●",
      --     --   -- this will set set the prefix to a function that returns the diagnostics icon based on the severity
      --     --   -- this only works on a recent 0.10.0 build. Will be set to "●" when not supported
      --     --   -- prefix = "icons",
      --     -- },
      --
      --     severity_sort = true, -- 根据诊断的严重性排序显示
      --     signs = {
      --       text = { -- 自定义左侧诊断符号的图标
      --         [vim.diagnostic.severity.ERROR] = LazyVim.config.icons.diagnostics.Error, -- 错误级别的图标
      --         [vim.diagnostic.severity.WARN] = LazyVim.config.icons.diagnostics.Warn, -- 警告级别的图标
      --         [vim.diagnostic.severity.HINT] = LazyVim.config.icons.diagnostics.Hint, -- 提示级别的图标
      --         [vim.diagnostic.severity.INFO] = LazyVim.config.icons.diagnostics.Info, -- 信息级别的图标
      --       },
      --     },
      --   },

      -- 添加需要的 LSP
      servers = {
        tsserver = {},
        lua_ls = {},
        marksman = {}, -- 为 Markdown 添加 marksman LSP
      },

      -- 禁用 LSP 的格式化功能
      setup = {
        ["*"] = function(_, opts)
          vim.diagnostic.config(opts.diagnostics)

          -- -- 自动显示浮动诊断窗口
          -- vim.api.nvim_create_autocmd("CursorHold", {
          --   callback = function()
          --     vim.diagnostic.open_float(nil, {
          --       focusable = false, -- 浮动窗口不会被光标选中
          --       border = "rounded", -- 圆角边框
          --       source = "always", -- 总是显示诊断来源
          --       scope = "line", -- 仅显示当前行的诊断
          --     })
          --   end,
          -- })

          opts.on_attach = function(client, bufnr)
            -- 禁用 LSP 的格式化功能
            client.server_capabilities.documentFormattingProvider = false
            client.server_capabilities.documentRangeFormattingProvider = false

            -- 定义一个快捷键函数
            local function buf_set_keymap(...)
              vim.api.nvim_buf_set_keymap(bufnr, ...)
            end

            -- 取消默认的 K 键绑定
            vim.api.nvim_buf_del_keymap(bufnr, "n", "K")
            buf_set_keymap("n", "K", "<cmd>Lspsaga hover_doc<CR>", { noremap = true, silent = true })
          end
        end,
      },
    },
  },
}
