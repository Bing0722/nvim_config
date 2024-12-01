return {
  "andersevenrud/nvim_context_vt",
  event = "VeryLazy",
  config = function()
    -- 配置 nvim_context_vt 插件
    require("nvim_context_vt").setup({
      enabled = false, -- 启用插件功能
      prefix = "", -- 设置上下文注释的前缀，默认为 '#'（适用于注释）
      highlight = "CustomContextVt", -- 使用自定义的高亮组
      disable_ft = { "markdown" }, -- 禁用 Markdown 文件的虚拟文本
    })
  end,
}
