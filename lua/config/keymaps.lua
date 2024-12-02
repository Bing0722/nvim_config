-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
local map = vim.keymap.set

-- 禁用 q 键的录制宏功能
vim.api.nvim_set_keymap("n", "q", ':echo "录制宏功能已被禁用." <CR>', { noremap = true, silent = true })

map("n", "<C-s>", ":write<CR>", { noremap = true, silent = true, desc = "保存" })

-- 更好的上下移动处理
map({ "n", "x" }, "j", "v:count == 0 ? 'gj' : 'j'", { desc = "下移", expr = true, silent = true })
map({ "n", "x" }, "<Down>", "v:count == 0 ? 'gj' : 'j'", { desc = "下移", expr = true, silent = true })
map({ "n", "x" }, "k", "v:count == 0 ? 'gk' : 'k'", { desc = "上移", expr = true, silent = true })
map({ "n", "x" }, "<Up>", "v:count == 0 ? 'gk' : 'k'", { desc = "上移", expr = true, silent = true })

-- 使用 vim.keymap.set 将快捷键映射到 accelerated-jk 的功能
map("n", "j", "<Plug>(accelerated_jk_gj)", { desc = "快速向下移动" })
map("n", "k", "<Plug>(accelerated_jk_gk)", { desc = "快速向上移动" })
-- 使用 Ctrl+hjkl 快速移动窗口
map("n", "<C-h>", "<C-w>h", { desc = "跳转到左侧窗口", remap = true })
map("n", "<C-j>", "<C-w>j", { desc = "跳转到下方窗口", remap = true })
map("n", "<C-k>", "<C-w>k", { desc = "跳转到上方窗口", remap = true })
map("n", "<C-l>", "<C-w>l", { desc = "跳转到右侧窗口", remap = true })

-- 使用 Ctrl+箭头键调整窗口大小
map("n", "<C-Up>", "<cmd>resize +2<cr>", { desc = "增加窗口高度" })
map("n", "<C-Down>", "<cmd>resize -2<cr>", { desc = "减少窗口高度" })
map("n", "<C-Left>", "<cmd>vertical resize -2<cr>", { desc = "减少窗口宽度" })
map("n", "<C-Right>", "<cmd>vertical resize +2<cr>", { desc = "增加窗口宽度" })

-- 移动行
map("n", "<A-j>", "<cmd>execute 'move .+' . v:count1<cr>==", { desc = "向下移动行" })
map("n", "<A-k>", "<cmd>execute 'move .-' . (v:count1 + 1)<cr>==", { desc = "向上移动行" })
map("i", "<A-j>", "<esc><cmd>m .+1<cr>==gi", { desc = "向下移动行（插入模式）" })
map("i", "<A-k>", "<esc><cmd>m .-2<cr>==gi", { desc = "向上移动行（插入模式）" })
map("v", "<A-j>", ":<C-u>execute \"'<,'>move '>+\" . v:count1<cr>gv=gv", { desc = "向下移动选中行" })
map("v", "<A-k>", ":<C-u>execute \"'<,'>move '<-\" . (v:count1 + 1)<cr>gv=gv", { desc = "向上移动选中行" })

-- 缓冲区切换
map("n", "<S-h>", "<cmd>bprevious<cr>", { desc = "切换到上一个缓冲区" })
map("n", "<S-l>", "<cmd>bnext<cr>", { desc = "切换到下一个缓冲区" })
map("n", "<leader>bd", function()
  Snacks.bufdelete()
end, { desc = "删除当前缓冲区" })
map("n", "<leader>bo", function()
  Snacks.bufdelete.other()
end, { desc = "删除其他缓冲区" })
map("n", "<leader>bD", "<cmd>:bd<cr>", { desc = "删除缓冲区和窗口" })

-- 按 ESC 清除搜索高亮
map({ "i", "n" }, "<esc>", "<cmd>noh<cr><esc>", { desc = "清除高亮并退出插入模式" })

-- 使 n 和 N 更加直观
map("n", "n", "'Nn'[v:searchforward].'zv'", { expr = true, desc = "下一个搜索结果" })
map("x", "n", "'Nn'[v:searchforward]", { expr = true, desc = "下一个搜索结果" })
map("o", "n", "'Nn'[v:searchforward]", { expr = true, desc = "下一个搜索结果" })
map("n", "N", "'nN'[v:searchforward].'zv'", { expr = true, desc = "上一个搜索结果" })
map("x", "N", "'nN'[v:searchforward]", { expr = true, desc = "上一个搜索结果" })
map("o", "N", "'nN'[v:searchforward]", { expr = true, desc = "上一个搜索结果" })

-- 按 K 使用 Keywordprg
map("n", "<leader>K", "<cmd>norm! K<cr>", { desc = "Keywordprg" })

-- 优化缩进
map("v", "<", "<gv")
map("v", ">", ">gv")

-- 按 K 使用 Keywordprg
map("n", "<leader>K", "<cmd>norm! K<cr>", { desc = "Keywordprg" })

-- 添加注释
map("n", "gco", "o<esc>Vcx<esc><cmd>normal gcc<cr>fxa<bs>", { desc = "在当前行下方添加注释" })
map("n", "gcO", "O<esc>Vcx<esc><cmd>normal gcc<cr>fxa<bs>", { desc = "在当前行上方添加注释" })

-- 调出 Lazy 管理器
map("n", "<leader>l", "<cmd>Lazy<cr>", { desc = "打开 Lazy 管理器" })

-- 为 insert 模式设置 esc 映射
map("i", "jj", "<esc>", { desc = "快速退出插入模式" })
map("i", "jk", "<esc>", { desc = "快速退出插入模式" })

-- diagnostic
local diagnostic_goto = function(next, severity)
  local go = next and vim.diagnostic.goto_next or vim.diagnostic.goto_prev
  severity = severity and vim.diagnostic.severity[severity] or nil
  return function()
    go({ severity = severity })
  end
end
map("n", "<leader>cd", vim.diagnostic.open_float, { desc = "显示当前行诊断信息" })
map("n", "]d", diagnostic_goto(true), { desc = "跳转到下一个诊断信息" })
map("n", "[d", diagnostic_goto(false), { desc = "跳转到上一个诊断信息" })
map("n", "]e", diagnostic_goto(true, "ERROR"), { desc = "跳转到下一个错误信息" })
map("n", "[e", diagnostic_goto(false, "ERROR"), { desc = "跳转到上一个错误信息" })
map("n", "]w", diagnostic_goto(true, "WARN"), { desc = "跳转到下一个警告信息" })
map("n", "[w", diagnostic_goto(false, "WARN"), { desc = "跳转到上一个警告信息" })

-- 窗口相关快捷键配置
map("n", "<leader>w", "<c-w>", { desc = "窗口命令模式", remap = true })
map("n", "<leader>-", "<C-W>s", { desc = "水平分割窗口", remap = true })
map("n", "<leader>|", "<C-W>v", { desc = "垂直分割窗口", remap = true })
map("n", "<leader>wd", "<C-W>c", { desc = "关闭当前窗口", remap = true })

-- 自定义快捷键，在括号或引号内跳出
vim.api.nvim_set_keymap("i", "<C-e>", "<Esc>la", { noremap = true, silent = true })
