local overseer = require("overseer")
local Job = require("plenary.job") -- 用于执行系统命令

-- 配置 Overseer
overseer.setup({
  templates = { "builtin", "user.cpp_build", "user.run_script", "user.run_cpp", "user.my_script" }, -- 定义模板
  strategy = {
    "toggleterm", -- 使用 toggleterm 作为任务运行的策略
    -- 在任务启动之前是否加载默认 shell
    use_shell = false, -- 不使用默认 shell
    -- 覆盖 toggleterm 的默认 "direction" 参数（窗口方向）
    direction = "float", -- 指定为浮动窗口
    -- 覆盖 toggleterm 的默认 "highlights" 参数（高亮配置）
    highlights = nil, -- 不指定，保持默认值
    -- 覆盖 toggleterm 的默认 "auto_scroll" 参数（自动滚动）
    auto_scroll = false, -- 禁止
    -- 在任务退出后，是否自动关闭并删除终端缓冲区
    close_on_exit = false, -- 不关闭窗口或删除缓冲区
    -- 在任务退出后，是否关闭窗口（不删除缓冲区）
    -- 可选值："never"（从不关闭）、"success"（仅任务成功时关闭）或 "always"（始终关闭）
    quit_on_exit = "never", -- 从不关闭窗口
    -- 当任务启动时，是否自动打开 toggleterm 窗口
    open_on_start = true, -- 启动任务时自动打开窗口
    -- 是否隐藏任务窗口，防止其在 toggleable 窗口中显示
    hidden = false, -- 不隐藏窗口
    -- 当终端创建时运行的命令
    -- 如果结合 `use_shell` 设置，可以在任务启动前运行某些命令
    on_create = function(term)
      vim.api.nvim_buf_set_keymap(term.bufnr, "n", "q", "<cmd>close<CR>", { noremap = true, silent = true })
    end,
  },
})

-- 创建一个运行c/c++、python...等的快捷操作 在浮动窗口显示结果
vim.api.nvim_create_user_command("Run", function()
  local filetype = vim.bo.filetype -- 获取当前文件的类型
  local script = { "sh", "python", "go", "lua" } -- 脚本文件类型
  local cpp = { "c", "cpp" } -- c/cpp类型
  local templates_name

  if table.concat(script, ","):find(filetype) then
    templates_name = "run script"
  elseif table.concat(cpp, ","):find(filetype) then
    templates_name = "run cpp"
  else
    vim.notify("不支持的文件类型: " .. filetype, vim.log.levels.ERROR)
    return -- 不支持的类型 直接退出
  end
  local K = require("config.function.input")
  K.input({ text_top = "[请输入要传入的参数]", default = "" }, function(input_args)
    local args = { arg1 = input_args }
    overseer.run_template({ name = templates_name, params = args }, function(task)
      if task then
        -- 如果任务存在，给任务添加一个 "restart_on_save" 组件
        -- 该组件会在保存指定路径文件时重新启动任务
        task:add_component({ "restart_on_save", paths = { vim.fn.expand("%:p") } })

        -- 获取当前窗口并执行任务
        local main_win = vim.api.nvim_get_current_win()
        overseer.run_action(task, "open float") -- 在任务中执行 "open float" 动作（在浮动窗口中打开任务输出）
        vim.api.nvim_set_current_win(main_win) -- 切换回原来的窗口
      else
        -- 如果任务创建失败，则弹出通知提示文件类型不受支持
        vim.notify("任务创建失败对于文件类型: " .. filetype, vim.log.levels.ERROR)
      end
    end)
  end)
end, {})

-- 指令测试
vim.api.nvim_create_user_command("Testcmd", function()
  -- 假设这是你执行的地方
  local args = { input_args = "test_argument" }

  -- 调用模板并传递参数
  overseer.run_template({ name = "my script", params = args }, function(task)
    -- 任务运行后的回调
    print("Task is running with the command: " .. vim.inspect(task.cmd))
  end)
end, {})
