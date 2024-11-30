return {
  "andersevenrud/nvim_context_vt",
  event = "VeryLazy",
  config = function()
    -- 配置 nvim_context_vt 插件
    require("nvim_context_vt").setup({
      enabled = false, -- 启用插件功能
      prefix = "", -- 设置上下文注释的前缀，默认为 '#'（适用于注释）
      highlight = "CustomContextVt", -- 使用自定义的高亮组
      disable_ft = { "markdown" }, -- 禁用 Markdown 文件的虚拟文本
    })
    -- -- 获取默认解析器函数
    -- local utils = require("nvim_context_vt.utils")
    --
    -- -- 自定义默认解析器函数
    -- utils.default_parser = function(node, _, opts)
    --   -- 获取当前语法节点的文本
    --   local text = utils.get_node_text(node, 0)[1]
    --
    --   -- 如果是 C/C++/CUDA/GLSL 文件，使用行注释格式
    --   if
    --     vim.bo.filetype == "c"
    --     or vim.bo.filetype == "cpp"
    --     or vim.bo.filetype == "cuda"
    --     or vim.bo.filetype == "glsl"
    --   then
    --     return string.format("// %s", text) -- 返回行注释格式
    --   end
    --
    --   -- 如果没有配置 commentstring，使用默认的前缀进行注释
    --   if vim.bo.commentstring == "" then
    --     return opts.prefix .. " " .. text -- 返回默认格式的注释
    --   end
    --
    --   -- 如果 commentstring 中包含空格，则使用它来格式化注释文本
    --   if vim.bo.commentstring:find("%s") then
    --     text = string.format(vim.bo.commentstring, text)
    --   else
    --     -- 否则将文本格式化为注释形式并去除多余空格
    --     text = vim.trim(string.format(vim.bo.commentstring, " " .. text .. " "))
    --   end
    --   return text -- 返回格式化后的注释文本
    -- end
  end,
}
