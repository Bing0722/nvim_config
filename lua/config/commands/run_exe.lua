-- 运行程序

local M = {}

function M.run_program(filetype)
  local notify = require("notify")
  -- 获取编译后的输出文件（假设是 a.out 或自定义的输出文件名）
  local output_file = vim.fn.expand("%:p:r") .. ".out"
  local cmd

  -- 判断文件类型并执行相应命令
  if filetype == "cpp" or filetype == "c" then
    if vim.fn.filereadable(output_file) == 0 then
      notify("未找到可执行文件! 请先编译代码.", "error", { title = "Run Program" })
      return
    end
    cmd = output_file
  elseif filetype == "lua" then
    cmd = "lua " .. vim.fn.expand("%:p")
  elseif filetype == "python" then
    cmd = "python3 " .. vim.fn.expand("%:p")
  else
    notify("不支持的可执行文件类型.", "error", { title = "Run Program" })
    return
  end

  local K = require("config.function.input")
  K.input({ text_top = "[请输入参数]", default = "" }, function(input_args)
    cmd = cmd .. " " .. input_args
    local output_message = "" -- 用于存储标准输出
    local error_message = "" -- 用于存储标准错误
    local program_success = false

    -- 异步运行程序并捕获输出
    vim.fn.jobstart(cmd, {
      stdout_buffered = true,
      stderr_buffered = true,
      on_stdout = function(_, data)
        if data then
          output_message = output_message .. table.concat(data, "\n") .. "\n"
        end
      end,
      on_stderr = function(_, data)
        if data then
          error_message = error_message .. table.concat(data, "\n") .. "\n"
        end
      end,
      on_exit = function(_, code)
        if code == 0 then
          program_success = true
        end

        -- 根据是否有输出内容决定是否发送通知
        if program_success then
          if output_message ~= "" then
            notify(output_message, "info", { title = "程序输出", timeout = 5000 })
          else
            -- 如果没有输出，但程序执行成功，则显示成功消息
            notify("程序成功执行! 没有输出.", "info", { title = "Run Program" })
          end
        else
          -- 如果有错误消息，显示错误消息
          if error_message ~= "" then
            notify("程序错误:\n" .. error_message, "error", { title = "Run Program" })
          else
            -- 如果没有错误输出，且程序执行失败，显示退出码
            notify("程序执行失败! 错误码:" .. code, "error", { title = "Run Program" })
          end
        end
      end,
    })
  end)
end

return M
