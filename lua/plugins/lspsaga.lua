return {
  "nvimdev/lspsaga.nvim",
  event = "LspAttach",
  opts = {
    ui = {
      border = "rounded", -- 圆角边框
    },
    -- 禁用不需要的模块
    symbol_in_winbar = { enable = false },
    lightbulb = { enable = false }, -- 正确的方式是将 enable 设置为 false
    code_action = { enable = false },
    rename = { enable = false },
    finder = { enable = false },
    diagnostic = { enable = false },
    hover = { -- 仅启用 hover 模块
      enable = true,
      max_width = 0.8, -- 设置最大宽度
      max_height = 0.6, -- 设置最大高度
      title = true, -- 显示标题
      -- 自定义渲染 Markdown
      render_markdown = true,
    },
    signature_help = {
      enable = false, -- 禁用 saga 签名功能以排除干扰
    },
  },
  config = function(_, opts)
    require("lspsaga").setup(opts)
    -- 将 K 键绑定到 hover_doc
    vim.keymap.set("n", "K", "<cmd>Lspsaga hover_doc<CR>", { desc = "Hover Documentation" })
  end,
}
