return {
  name = "run script", -- 任务名称
  builder = function() -- 构建任务的函数
    local file = vim.fn.expand("%:p") -- 获取当前文件的绝对路径
    local cmd = { file } -- 默认命令：直接运行当前文件
    local filetype = vim.bo.filetype
    if filetype == "go" then -- 如果文件类型是 Go，则使用 "go run" 来执行文件
      cmd = { "go", "run", file }
    end
    if filetype == "python" then -- 如果是python文件 则使用 python3 来执行
      cmd = { "python3", file }
    end
    if filetype == "sh" then -- 如果是sh文件 则使用 bash 来执行
      cmd = { "bash", file }
    end
    if filetype == "lua" then -- 如果是lua文件 则使用 lua来执行
      cmd = { "lua", file }
    end
    return { -- 返回任务的配置
      cmd = cmd,
      components = { -- 任务的组件配置
        { "on_output_quickfix", set_diagnostics = true }, -- 输出到快速修复列表（quickfix），并设置诊断信息
        "on_result_diagnostics", -- 结果的诊断信息
        "default", -- 默认组件
      },
    }
  end,
  condition = { -- 配置任务的适用条件
    filetype = { "sh", "python", "go", "lua" }, -- 仅在文件类型为 sh、python 或 go 时触发此任务
  },
}
