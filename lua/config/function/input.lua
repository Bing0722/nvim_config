-- input接口

local M = {}

-- 输入栏函数
-- options:
--    text_top: 输入栏的上方文字内容
--    default:  输入栏的默认文字
-- callback: 回调函数
function M.input(options, callback)
  local Input = require("nui.input")
  local event = require("nui.utils.autocmd").event
  local notify = require("notify")

  -- 设置输入框的位置和样式
  local input = Input({
    -- position = "50%", -- 输入框相对于屏幕居中
    position = {
      row = math.floor(vim.o.lines / 8), -- 在屏幕上方的1/4位置
      col = math.floor((vim.o.columns - 40) / 2), -- 水平居中
    },
    size = {
      width = 40, -- 设置宽度
    },
    border = {
      style = "rounded", -- 设置边框样式
      text = {
        top = options.text_top,
        top_align = "center", -- 上方文字居中
      },
    },
    win_options = {
      winhighlight = "Normal:Normal,FloatBorder:Normal", -- 设置窗口的高亮样式
    },
  }, {
    prompt = ">", -- 输入提示文字
    default_value = options.default, -- 默认值为空
    on_close = function() end,
    on_submit = function(value)
      -- 回调函数
      callback(value)
    end,
  })

  input:map("n", "<Esc>", function()
    input:unmount()
    callback(nil)
  end, { noremap = true })

  -- 打开输入框
  input:mount()

  -- 当光标离开缓冲区时卸载输入框
  input:on(event.BufLeave, function()
    input:unmount()
  end)
end

return M
