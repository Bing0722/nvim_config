return {
  "akinsho/toggleterm.nvim",
  version = "*", -- 确保使用最新稳定版本
  config = function()
    local toggleterm = require("toggleterm")
    toggleterm.setup({
      -- 设置终端尺寸
      size = function(term)
        if term.direction == "horizontal" then
          return 10 -- 水平终端的高度
        elseif term.direction == "vertical" then
          return vim.o.columns * 0.3 -- 垂直终端的宽度
        end
      end,
      layout_config = {
        width = 0.98, -- 窗口布局宽度
        preview_cutoff = 1, -- 预览窗口的最小宽度
      },
      hide_numbers = true, -- 在 toggleterm 窗口中隐藏行号
      autochdir = true, -- 自动切换当前目录为终端的所在目录
      shade_terminals = false, -- 是否禁用终端背景色的阴影效果

      -- shell = "zsh", -- 设置默认 shell
      shell = "bash",
      -- start_in_insert = true, -- 启动时进入插入模式

      -- 禁止自动滚动到终端的最底部
      auto_scroll = false,

      float_opts = {
        border = "curved", -- 设置浮动窗口的边框为 'curved'（圆角边框）
        width = 90, -- 设置浮动窗口的宽度为 70
        height = 28, -- 设置浮动窗口的高度为 18
        winblend = 0, -- 设置窗口的透明度为 3
      },

      -- 配置终端窗口的高亮样式
      highlights = {
        Normal = {
          guibg = "none", -- 设置正常模式下的背景为透明
        },
        NormalFloat = {
          link = "Normal", -- 将浮动窗口的 NormalFloat 高亮与 Normal 高亮绑定
        },
        FloatBorder = {
          guibg = "none", -- 设置浮动窗口边框的背景为透明
        },
      },

      -- 设置窗口栏配置（如果不需要窗口栏可禁用）
      winbar = {
        enabled = false, -- 禁用窗口栏
        name_formatter = function(term) -- 终端的名称格式化函数
          return term.name
        end,
      },
      close_on_exit = false, -- 退出时关闭终端
    })

    -- 定义 Terminal 实例
    local Terminal = require("toggleterm.terminal").Terminal

    -- 定义浮动终端
    local ta = Terminal:new({
      direction = "float", -- 浮动窗口
    })

    -- 定义垂直终端
    local tb = Terminal:new({
      direction = "vertical", -- 垂直窗口
    })

    -- 定义水平终端
    local tc = Terminal:new({
      direction = "horizontal", -- 水平窗口
    })

    -- 定义功能模块
    local M = {}

    -- 切换浮动终端
    M.toggleA = function()
      if ta:is_open() then
        ta:close()
        return
      end
      tb:close()
      tc:close()
      ta:open()
    end

    -- 切换垂直终端
    M.toggleB = function()
      if tb:is_open() then
        tb:close()
        return
      end
      ta:close()
      tc:close()
      tb:open()
    end

    -- 切换水平终端
    M.toggleC = function()
      if tc:is_open() then
        tc:close()
        return
      end
      ta:close()
      tb:close()
      tc:open()
    end

    -- 键位绑定
    -- 按 tt 打开/关闭浮动终端
    -- 按 tb 打开/关闭垂直终端
    -- 按 tc 打开/关闭水平终端
    M.mapToggleTerm = function()
      vim.keymap.set({ "n", "t" }, "tt", function()
        M.toggleA()
      end, { noremap = true, silent = true, desc = "Toggle Float Terminal" })
      vim.keymap.set({ "n", "t" }, "tb", function()
        M.toggleB()
      end, { noremap = true, silent = true, desc = "Toggle Vertical Terminal" })
      vim.keymap.set({ "n", "t" }, "tc", function()
        M.toggleC()
      end, { noremap = true, silent = true, desc = "Toggle Horizontal Terminal" })
      vim.keymap.set({ "n", "t" }, "tg", function()
        M.toggleG()
      end, { noremap = true, silent = true, desc = "Toggle Lazygit" })
    end

    -- 调用按键映射
    M.mapToggleTerm()
  end,
}
