return {
  "dgagn/diagflow.nvim",
  config = function()
    require("diagflow").setup({
      enable = false, -- 启用诊断功能
      max_width = 60, -- 诊断消息的最大宽度
      max_height = 10, -- 每个诊断的最大高度
      severity_colors = { -- 每个诊断严重性级别使用的高亮组
        error = "DiagnosticFloatingError", -- 错误的高亮组
        warning = "DiagnosticFloatingWarn", -- 警告的高亮组
        info = "DiagnosticFloatingInfo", -- 信息的高亮组
        hint = "DiagnosticFloatingHint", -- 提示的高亮组
      },
      filters = {
        {
          source = "vim",
          pattern = ".*",
        },
      },
      format = function(diagnostic) -- 诊断消息的格式化函数
        if vim.fn.mode() == "i" then -- 如果是插入模式，则不显示诊断信息
          return ""
        end
        local severity = vim.diagnostic.severity[diagnostic.severity] -- 获取诊断的严重性
        local status, sign = pcall(function()
          return vim.trim(vim.fn.sign_getdefined(
            "DiagnosticSign" .. severity:lower():gsub("^%l", string.upper) -- 根据严重性获取对应的标志符
          )[1].text)
        end)
        if not status then -- 如果获取标志失败，则使用默认的严重性首字母作为标志
          sign = severity:sub(1, 1)
        end
        return sign .. " " .. diagnostic.message -- 返回格式化的诊断消息
      end,

      -- 自定义诊断消息格式化函数
      gap_size = 0, -- 诊断消息与其他元素之间的间隙大小
      scope = "line", -- 诊断消息的作用范围，'line'表示显示整行的诊断，'cursor'表示只显示光标下的诊断
      padding_top = 0, -- 顶部填充
      padding_right = 0, -- 右侧填充
      text_align = "left", -- 文字对齐方式，'left'表示左对齐，'right'表示右对齐
      placement = "inline", -- 诊断消息的显示位置，'top'表示显示在顶部，'inline'表示在行内显示
      inline_padding_left = 2, -- 如果诊断消息显示在行内，左侧填充
      update_event = { "DiagnosticChanged", "BufReadPost", "BufEnter" }, -- 更新诊断缓存的事件
      toggle_event = { "InsertEnter", "InsertLeave" }, -- 切换诊断显示的事件，例如进入插入模式时隐藏诊断，离开时显示
      show_sign = false, -- 是否在诊断消息前显示诊断标志，设置为true则显示
      render_event = { "DiagnosticChanged", "CursorMoved" }, -- 渲染诊断的事件
      border_chars = { -- 自定义诊断消息的边框字符
        top_left = "┌",
        top_right = "┐",
        bottom_left = "└",
        bottom_right = "┘",
        horizontal = "─",
        vertical = "│",
      },
      show_borders = false, -- 是否显示边框
    })

    local nerd_fonts = true
    -- 根据是否启用 Nerd Fonts 设置诊断标志的文本
    if nerd_fonts then
      vim.fn.sign_define("DiagnosticSignError", { text = "", texthl = "DiagnosticSignError" }) -- 错误标志
      vim.fn.sign_define("DiagnosticSignWarn", { text = "", texthl = "DiagnosticSignWarn" }) -- 警告标志
      vim.fn.sign_define("DiagnosticSignInfo", { text = "", texthl = "DiagnosticSignInfo" }) -- 信息标志
      vim.fn.sign_define("DiagnosticSignHint", { text = "", texthl = "DiagnosticSignHint" }) -- 提示标志
    else
      vim.fn.sign_define("DiagnosticSignError", { text = "E", texthl = "DiagnosticSignError" }) -- 错误标志
      vim.fn.sign_define("DiagnosticSignWarn", { text = "W", texthl = "DiagnosticSignWarn" }) -- 警告标志
      vim.fn.sign_define("DiagnosticSignInfo", { text = "I", texthl = "DiagnosticSignInfo" }) -- 信息标志
      vim.fn.sign_define("DiagnosticSignHint", { text = "?", texthl = "DiagnosticSignHint" }) -- 提示标志
    end
  end,
}
