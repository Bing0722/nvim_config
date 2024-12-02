local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  spec = {
    -- add LazyVim and import its plugins
    { "LazyVim/LazyVim", import = "lazyvim.plugins" },

    { import = "lazyvim.plugins.extras.ui.edgy" },

    { import = "lazyvim.plugins.extras.editor.telescope" },
    { import = "lazyvim.plugins.extras.editor.aerial" }, -- 快速浏览大纲
    { import = "lazyvim.plugins.extras.editor.overseer" }, -- 自定义任务
    { import = "lazyvim.plugins.extras.editor.refactoring" }, -- 重构
    { import = "lazyvim.plugins.extras.editor.navic" }, -- 上方显示代码上下文
    { import = "lazyvim.plugins.extras.editor.outline" }, -- 显示大纲
    { import = "lazyvim.plugins.extras.editor.inc-rename" }, -- 丝滑的重命名
    { import = "lazyvim.plugins.extras.editor.illuminate" }, -- 重复单词可以看到光标
    -- { import = "lazyvim.plugins.extras.editor.fzf" },

    -- 启动时间
    { import = "lazyvim.plugins.extras.util.startuptime" },
    { import = "lazyvim.plugins.extras.util.chezmoi" },
    { import = "lazyvim.plugins.extras.util.dot" },
    { import = "lazyvim.plugins.extras.util.gitui" },
    { import = "lazyvim.plugins.extras.util.octo" },
    { import = "lazyvim.plugins.extras.util.project" },

    -- c++
    { import = "lazyvim.plugins.extras.lang.cmake" },
    { import = "lazyvim.plugins.extras.lang.clangd" },

    -- markdown
    { import = "lazyvim.plugins.extras.lang.markdown" },

    -- python
    { import = "lazyvim.plugins.extras.lang.python" },

    -- Neogen文档
    { import = "lazyvim.plugins.extras.coding.neogen" },
    { import = "lazyvim.plugins.extras.coding.luasnip" },
    { import = "lazyvim.plugins.extras.coding.mini-comment" },
    { import = "lazyvim.plugins.extras.coding.mini-surround" }, -- 快速和高效地操作问本周围的符号

    { import = "lazyvim.plugins.extras.ui.mini-indentscope" },
    -- { import = "lazyvim.plugins.extras.ui.treesitter-context" },
    -- { import = "lazyvim.plugins.extras.ui.mini-starter" },
    -- { import = "lazyvim.plugins.extras.ui.alpha" },
    -- { import = "lazyvim.plugins.extras.ui.dashboard-nvim" },

    -- lsp的某些配置
    { import = "lazyvim.plugins.extras.lsp.neoconf" },
    { import = "lazyvim.plugins.extras.lsp.none-ls" },

    -- 调试
    { import = "lazyvim.plugins.extras.dap.core" },
    { import = "lazyvim.plugins.extras.dap.nlua" },
    -- import/override with your plugins
    { import = "plugins" },
  },
  defaults = {
    -- By default, only LazyVim plugins will be lazy-loaded. Your custom plugins will load during startup.
    -- If you know what you're doing, you can set this to `true` to have all your custom plugins lazy-loaded by default.
    lazy = false,
    -- It's recommended to leave version=false for now, since a lot the plugin that support versioning,
    -- have outdated releases, which may break your Neovim install.
    version = false, -- always use the latest git commit
    -- version = "*", -- try installing the latest stable version for plugins that support semver
  },
  install = { colorscheme = { "tokyonight", "habamax" } },
  checker = {
    enabled = true, -- check for plugin updates periodically
    notify = false, -- notify on update
  }, -- automatically check for plugin updates
  performance = {
    rtp = {
      -- disable some rtp plugins
      disabled_plugins = {
        "gzip",
        -- "matchit",
        -- "matchparen",
        -- "netrwPlugin",
        "tarPlugin",
        "tohtml",
        "tutor",
        "zipPlugin",
      },
    },
  },
})
