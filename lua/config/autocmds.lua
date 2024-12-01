-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here

local notify = require("notify")

-- 编译程序
vim.keymap.set("n", "<F5>", function()
  local compile = require("config/commands/compile")
  -- 保存当前文件
  vim.cmd("write") -- 你也可以使用 :w 命令手动保存
  local filetype = vim.bo.filetype -- 获取当前缓冲区的文件类型
  if filetype == "cpp" or filetype == "c" then
    compile.compile_program(filetype)
  else
    notify("该文件类型不支持编译!", "error", { title = "Compile Program" })
  end
end)

-- 运行程序
vim.keymap.set("n", "<F6>", function()
  local run_exe = require("config/commands/run_exe")
  -- 保存当前文件
  vim.cmd("write") -- 你也可以使用 :w 命令手动保存
  local filetype = vim.bo.filetype -- 获取当前缓冲区的文件类型
  run_exe.run_program(filetype)
end)

-- local save = require("config/function/select")
-- vim.keymap.set("n", "<F8>", function()
--   save.ui()
-- end)

vim.keymap.set("n", "<F8>", "<cmd>Run<CR>")

require("config/commands/autotask")
