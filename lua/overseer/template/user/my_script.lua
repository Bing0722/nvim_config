-- 任务模板定义
return {
  name = "my script", -- 任务名称
  builder = function(params) -- 使用params获取传入的参数
    -- 打印调试信息，查看传递的参数
    print("Received params: " .. vim.inspect(params))

    -- 获取当前文件路径
    local file = vim.fn.expand("%:p") -- 获取当前文件的绝对路径
    local filename = vim.fn.expand("%:t:r") -- 获取当前文件名，不带扩展名

    -- 使用传递的参数来构建命令
    local cmd = { "echo", "Running file:", filename, "with args:", params.input_args }

    -- 返回任务配置
    return {
      cmd = cmd, -- 执行命令
      components = { -- 配置任务组件
        "default", -- 默认组件
      },
    }
  end,
  condition = {
    filetype = { "lua" }, -- 仅在 lua 文件时执行此任务
  },
}
