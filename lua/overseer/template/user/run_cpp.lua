return {
  name = "run cpp", -- 任务名称
  builder = function(params) -- 构建任务的函数
    local file = vim.fn.expand("%:p") -- 获取当前文件的绝对路径
    local dir = vim.fn.expand("%:p:h") -- 获取当前文件所在的目录路径
    local filename = vim.fn.expand("%:t:r") -- 获取当前文件名，不带扩展名
    local output_file = dir .. "/" .. filename .. ".out" -- 使用源文件名加 .out 扩展名
    print(params.arg1)
    local cmd = { output_file, params.arg1 } -- 运行该可执行文件

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
    filetype = { "c", "cpp" }, -- 仅在文件类型为 c、cpp 时触发此任务
  },
}
