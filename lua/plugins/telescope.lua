return {
  "nvim-telescope/telescope.nvim",
  keys = {
    {
      "<leader>fm",
      function()
        require("telescope.builtin").find_files({
          prompt_title = "Find Markdown Files",
          cwd = vim.fn.getcwd(),
          file_ignore_patterns = { "node_modules" },
          find_command = { "rg", "--files", "--glob", "*.md" },
        })
      end,
      desc = "Find Markdown Files",
    },
  },
  opts = {
    defaults = {
      layout_strategy = "horizontal",
      layout_config = { prompt_position = "top" },
      sorting_strategy = "ascending",
      winblend = 0,
    },
  },
}
