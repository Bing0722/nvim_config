return {
  "nvim-treesitter/nvim-treesitter",
  opts = {
    ensure_installed = {
      "cpp",
      "lua",
      "markdown",
      "markdown_inline",
      "c",
    },
    highlight = {
      enable = true,
      additional_vim_regex_highlighting = false, -- 避免与 Vim 的内置高亮冲突
    },
    indent = { enable = true }, -- 开启缩进模块
  },
}
