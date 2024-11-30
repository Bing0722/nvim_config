return {
  -- notify 通知 --
  {
    "rcarriga/nvim-notify",
    event = "VeryLazy",
    config = function()
      local notify = require("notify")

      -- 基本设置
      notify.setup({
        stages = "static", -- 动画效果
        timeout = 3000, -- 通知自动消失时间（毫秒）
        background_colour = "#000000", -- 背景颜色
        fps = 30, -- 动画帧率
        render = "default", -- 渲染样式，可选 "minimal"
        -- level = 2, -- 设置通知的级别（info, warn, error）
        -- max_width = 50, -- 最大宽度
        -- min_width = 20, -- 最小宽度
        -- max_height = 10, -- 最大高度
        -- top_down = true, -- 是否从顶部显示
        -- icons = { ERROR = "", WARN = "", INFO = "", DEBUG = "" }, -- 自定义图标
        --
        -- -- 修正 time_formats，应该是一个表格而不是字符串
        -- time_formats = {
        --   "%H:%M:%S", -- 24小时制
        --   "%I:%M:%S %p", -- 12小时制带AM/PM
        -- },
        -- on_open = function() -- 打开通知时的回调
        --   -- print("通知打开")
        -- end,
        -- on_close = function() -- 关闭通知时的回调
        --   -- print("通知关闭")
        -- end,
        -- minimum_width = 30, -- 最小宽度
      })

      -- 替换默认的 `vim.notify`
      vim.notify = notify
    end,
  },
}
