local overseer = require("overseer")
local Job = require("plenary.job") -- 用于执行系统命令

-- 配置 Overseer
overseer.setup({
  templates = { "builtin", "user.cpp_build_run" }, -- 定义 C++ 编译运行模板
  strategy = {
    -- 使用 ToggleTerm 作为执行任务的策略
    "toggleterm",
    use_shell = false, -- 在启动任务之前加载默认的 shell
    direction = "float", -- 覆盖 toggleterm 默认的 "direction" 参数
    highlights = nil, -- 覆盖 toggleterm 默认的 "highlights" 参数
    auto_scroll = nil, -- 覆盖 toggleterm 默认的 "auto_scroll" 参数
    close_on_exit = false, -- 任务退出时自动关闭并删除终端缓冲区
    quit_on_exit = "never", -- 任务完成后不关闭 ToggleTerm
    open_on_start = true, -- 任务开始时自动打开 toggleterm 窗口
    hidden = false, -- 和 toggleterm 的 "hidden" 参数相似，防止任务在切换窗口时被渲染
    on_create = nil, -- 没有指定创建时要执行的命令
  },
})

-- 创建 C++ 编译和运行的任务
vim.api.nvim_create_user_command("RunCpp", function()
  -- 创建一个新的任务来运行编译后的程序
  overseer
    .new_task({
      cmd = "./a.out", -- 运行编译后的程序
      -- strategy = {
      --   "toggleterm", -- 使用 toggleterm 显示输出
      --   direction = "float", -- 设置为浮动窗口
      --   float_opts = {
      --     border = "rounded", -- 设置边框样式为圆角
      --     height = 20, -- 设置浮动窗口的高度
      --     width = 80, -- 设置浮动窗口的宽度
      --     winblend = 10, -- 设置窗口的透明度
      --   },
      -- },

      components = {
        {
          "on_output_quickfix", -- 输出每一行的信息
          open = false,
          -- close_on_exit = false, -- 任务完成后自动关闭浮动窗口
        },
        { "on_complete_dispose", timeout = 30 }, -- 完成后 30 秒内清除任务
        "default", -- 默认组件
      },
    })
    :start() -- 启动运行任务
end, {})

-- 自定义命令 WatchRun：运行脚本并在文件保存时自动重新启动
vim.api.nvim_create_user_command("WatchRun", function()
  -- 使用 "run script" 模板来运行任务
  overseer.run_template({ name = "run script" }, function(task)
    if task then
      -- 如果任务成功创建，添加一个组件：在文件保存时重启任务
      task:add_component({ "restart_on_save", paths = { vim.fn.expand("%:p") } })
      local main_win = vim.api.nvim_get_current_win() -- 获取当前窗口
      overseer.run_action(task, "open") -- 打开任务的终端窗口
      vim.api.nvim_set_current_win(main_win) -- 恢复到原来的窗口
    else
      -- 如果任务类型不支持当前文件类型，则显示错误信息
      vim.notify("WatchRun not supported for filetype " .. vim.bo.filetype, vim.log.levels.ERROR)
    end
  end)
end, {})

-- 自定义命令 Grep：使用 grepprg 执行搜索并显示输出
vim.api.nvim_create_user_command("Grep", function(params)
  -- 将参数插入到 grepprg 命令中的 `$*` 位置
  local cmd, num_subs = vim.o.grepprg:gsub("%$%*", params.args)
  if num_subs == 0 then
    cmd = cmd .. " " .. params.args -- 如果没有替换，手动附加参数
  end

  -- 创建并启动任务
  local task = overseer.new_task({
    cmd = vim.fn.expandcmd(cmd), -- 执行的命令
    components = {
      {
        "on_output_quickfix", -- 将输出信息显示在 quickfix 列表中
        errorformat = vim.o.grepformat, -- 使用 `grepformat` 配置来解析输出
        open = not params.bang, -- 如果没有 `!` 参数，则自动打开 quickfix 窗口
        open_height = 8, -- quickfix 窗口的高度
        items_only = true, -- 只显示错误项
      },
      { "on_complete_dispose", timeout = 30 }, -- 任务完成后 30 秒内删除任务
      "default", -- 默认组件
    },
  })
  task:start() -- 启动任务
end, { nargs = "*", bang = true, complete = "file" })

-- 自定义命令 Make：执行 `makeprg` 命令
vim.api.nvim_create_user_command("Make", function(params)
  -- 将参数插入到 makeprg 命令中的 `$*` 位置
  local cmd, num_subs = vim.o.makeprg:gsub("%$%*", params.args)
  if num_subs == 0 then
    cmd = cmd .. " " .. params.args -- 如果没有替换，手动附加参数
  end

  -- 创建并启动任务
  local task = require("overseer").new_task({
    cmd = vim.fn.expandcmd(cmd), -- 执行的命令
    components = {
      { "on_output_quickfix", open = not params.bang, open_height = 8 }, -- 输出显示在 quickfix 窗口中
      "default", -- 默认组件
    },
  })
  task:start() -- 启动任务
end, {
  desc = "Run your makeprg as an Overseer task", -- 任务描述
  nargs = "*", -- 允许多个参数
  bang = true, -- 支持 `!` 参数
})

-- 自定义命令 OverseerRestartLast：重启最近的任务
vim.api.nvim_create_user_command("OverseerRestartLast", function()
  local tasks = overseer.list_tasks({ recent_first = true }) -- 获取最近的任务列表
  if vim.tbl_isempty(tasks) then
    vim.notify("No tasks found", vim.log.levels.WARN) -- 如果没有任务，则显示警告
  else
    -- 重启最近的任务
    overseer.run_action(tasks[1], "restart")
  end
end, {})
