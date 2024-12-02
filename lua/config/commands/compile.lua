-- 编译程序
local M = {}

function M.compile_program(filetype)
  local notify = require("notify")
  -- 弹出输入框，允许用户输入编译参数
  -- 系统自带的
  -- vim.ui.input({ prompt = "请输入参数: ", default = "-std=c++17 -g" }, function(input)
  local K1 = require("config/function/input")
  K1.input({ text_top = "[请输入编译时的参数]", default = "-std=c++17 -g" }, function(input_args)
    -- 如果用户取消输入，则返回
    if not input_args or input_args == "" then
      notify("编译已取消.", "warn", { title = "Compile Program" })
      return
    end
    local K2 = require("config/function/input")
    K2.input({ text_top = "[请输入需要链接的库]", default = "" }, function(input_link)
      local is_link
      if input_link == "" then
        is_link = "无需进行链接.\n"
      elseif not input_link then
        notify("编译已取消.", "warn", { title = "Compile Program" })
        return
      else
        is_link = "链接到 -> " .. input_link .. "\n"
      end

      -- 获取当前文件的完整路径和输出文件的路径
      local filename = vim.fn.expand("%:p")
      local output = vim.fn.expand("%:p:r") .. ".out"
      local cmd

      -- 根据文件类型决定编译命令
      if filetype == "cpp" then
        cmd = string.format("g++ %s %s -o %s %s", input_args, filename, output, input_link)
      elseif filetype == "c" then
        cmd = string.format("gcc %s %s -o %s %s", input_args, filename, output, input_link)
      else
        notify("不支持该文件类型的编译。", "error", { title = "Compile Program" })
        return
      end

      local output_message = "" -- 用于存储标准输出
      local error_message = "" -- 用于存储标准错误
      local program_success = false

      -- 异步执行编译命令
      vim.fn.jobstart(cmd, {
        stdout_buffered = true,
        stderr_buffered = true,
        on_stdout = function(_, data)
          notify(is_link .. "正在编译...\n" .. cmd, "info", { title = "Compile Program" })
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
              notify(
                "编译成功!\n输出到:" .. output .. "\n" .. output_message,
                "info",
                { title = "Compile Program" }
              )
            else
              notify("编译成功:\n" .. output_message, "info", { title = "Compile Program" })
            end
          else
            -- 如果有错误消息，显示错误消息
            if error_message ~= "" then
              notify("编译错误: " .. error_message, "error", { title = "Compile Program" })
            else
              -- 如果没有错误输出，且程序执行失败，显示退出码
              notify("编译失败! 错误码: " .. code, "error", { title = "Compile Program" })
            end
          end
        end,
      })
    end)
  end)
end

return M
