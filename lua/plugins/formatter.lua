return {
  "mhartington/formatter.nvim",
  event = { "BufReadPost", "BufNewFile" }, -- 在打开文件时加载
  config = function()
    require("formatter").setup({
      logging = false, -- 启用日志
      log_level = vim.log.levels.ERROR, -- 设置日志级别
      filetype = {
        -- 为 C 配置格式化工具
        c = {
          function()
            return {
              exe = "clang-format", -- 使用 clang-format
              args = { "---assume-filename=/home/bing/.config/nvim/config/.clang-format" },
              stdin = true,
            }
          end,
        },
        -- 为 C++ 配置格式化工具
        cpp = {
          function()
            return {
              exe = "clang-format", -- 使用 clang-format
              -- args = { "--assume-filename", vim.api.nvim_buf_get_name(0) },
              args = { "--assume-filename=/home/bing/.config/nvim/config/.clang-format" },
              stdin = true,
            }
          end,
        },
        -- python 格式工具
        python = {
          -- black
          function()
            return {
              exe = "black",
              args = {},
            }
          end,
        },
        -- lua 格式工具
        lua = {
          function()
            return {
              exe = "stylua",
              args = {
                "-",
              },
              stdin = true,
            }
          end,
        },
      },
    })
  end,
}
