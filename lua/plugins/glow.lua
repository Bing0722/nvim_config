return {
  "ellisonleao/glow.nvim",
  cmd = "Glow", -- 仅在使用 `:Glow` 命令时加载
  opts = {
    border = "rounded", -- 美化窗口边框
    width_ratio = 0.8, -- 窗口宽度比例
    height_ratio = 0.8, -- 窗口高度比例
  },
  keys = {
    { "<leader>mg", ":Glow<CR>", desc = "Preview Markdown" }, -- 添加快捷键
  },
}
