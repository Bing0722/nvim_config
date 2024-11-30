return {
  {
    -- 插件名称：accelerated-jk
    -- 功能：加速上下移动光标，提高导航效率
    "rhysd/accelerated-jk",
    config = function()
      -- 使用 vim.keymap.set 将快捷键映射到 accelerated-jk 的功能
      vim.keymap.set("n", "j", "<Plug>(accelerated_jk_gj)", { desc = "快速向下移动" })
      vim.keymap.set("n", "k", "<Plug>(accelerated_jk_gk)", { desc = "快速向上移动" })
    end,
  },
}
