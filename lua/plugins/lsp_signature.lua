return {
  -- 插件配置：确保插件如 `lsp_signature.nvim` 在 LSP 配置后加载
  {
    "ray-x/lsp_signature.nvim",
    event = "InsertEnter",
    enabled = false,
    config = function()
      require("lsp_signature").setup({
        bind = true, -- 绑定按键，启用后可以通过按键手动触发签名提示
        doc_lines = 10, -- 设置显示的文档行数，0 表示不显示文档
        handler_opts = {
          border = "rounded", -- 设置浮动窗口的边框类型，"none" 表示没有边框
        },
        wrap = true, -- 允许文档/签名文本在浮动窗口内换行，如果你的 LSP 返回的文档/签名太长则非常有用
        floating_window = true, -- 设置是否使用浮动窗口来显示签名提示，false 表示不使用浮动窗口
        floating_window_above_cur_line = true, -- 如果启用了浮动窗口，设置它是否显示在当前行之上
        floating_window_off_x = 1, -- 设置浮动窗口相对于光标的水平偏移量
        floating_window_off_y = 0, -- 设置浮动窗口相对于光标的垂直偏移量
        fix_pos = false, -- 设置为 true，浮动窗口将不会自动关闭，直到所有参数输入完毕
        hint_prefix = " ", -- 设置提示前缀，如果启用了 nerd_fonts 则使用一个图标，默认没有前缀
        hint_enable = true, -- 启用虚拟提示
        -- hint_scheme = "Comment", -- 设置提示的高亮颜色，"Comment" 表示使用注释的高亮颜色
        hint_scheme = "String", -- 提示的高亮颜色方案
        hi_parameter = "LspSignatureActiveParameter", -- 设置当前参数的高亮颜色
        debug = false, -- 启用调试模式，如果为 true 会输出更多的调试信息
        toggle_key = "<M-p>", -- 设置触发签名提示显示或隐藏的快捷键（Alt + p）
        toggle_key_flip_floatwin_setting = true, -- 切换浮动窗口设置的快捷键，启用后会根据当前设置切换浮动窗口的状态
        select_signature_key = "<M-n>", -- 设置选择函数签名的快捷键（Alt + n）
        timer_interval = 80, -- 设置定时器的间隔时间，用于控制刷新签名提示的频率，单位是毫秒
        close_timeout = 4000, -- 当输入完最后一个参数后，浮动窗口将关闭，单位为毫秒
        hint_inline = function()
          return false
        end, -- 是否将提示内联显示（仅支持 nvim 0.10 及以上版本）
        always_trigger = false, -- 有时在新行或参数中间显示签名可能会造成困扰，设置为 false 来避免这种情况（解决 #58）
        zindex = 200, -- 设置浮动窗口的层级，默认情况下它将位于所有浮动窗口之上
        transparency = nil, -- 默认禁用，允许浮动窗口透明，透明度值范围为 1~100
      })
    end,
  },
}
