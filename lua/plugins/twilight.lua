return {
  "folke/zen-mode.nvim",
  {
    "folke/twilight.nvim",
    config = function()
      require("twilight").setup({
        -- 配置暗淡效果
        dimming = {
          alpha = 0.25, -- 设置暗淡的透明度，数值越低，效果越明显
          -- 尝试从高亮组中获取前景色，若获取失败，则使用默认颜色
          color = { "Normal", "#ffffff" }, -- 正常模式下的前景色，默认为白色
          term_bg = "#000000", -- 如果 guibg=NONE，则使用此背景色来计算文本颜色
          inactive = true, -- 当为 true 时，其他窗口将完全变暗（除非它们包含当前缓冲区）
        },

        -- 设置当前行周围显示的上下文行数
        context = 10, -- 当前行的上下文区域，默认为 10 行

        -- 开启 Treesitter 支持（可用于解析和高亮显示语言结构）
        treesitter = true, -- 如果当前文件类型支持 Treesitter，启用此功能

        -- 当启用 Treesitter 时，自动扩展可视文本。你可以控制某些节点类型始终展开
        expand = {
          "function", -- 总是展开函数节点
          "method", -- 总是展开方法节点
          "table", -- 总是展开表格节点
          "if_statement", -- 总是展开 if 语句节点
        },

        -- 排除的文件类型，不应用该插件
        exclude = {}, -- 可以指定不启用此功能的文件类型，默认为空，表示没有排除文件类型
      })
    end,
  },
}
