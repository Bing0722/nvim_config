return {
  {
    "folke/noice.nvim",
    opts = {
      presets = {
        lsp_doc_border = true,
      },
      lsp = {
        -- signature = {
        --   enabled = false, -- 关闭签名
        -- },
        signature = {
          opts = {
            size = {
              height = 8, -- 设置窗口的高度
              width = 80, -- 设置窗口的宽度
            },
            win_options = {
              winblend = 10,
            },
            floating = true, -- 确保签名窗口为浮动窗口
          },
        },
      },
    },
  },
}
