-- nvim-window for hinting windows
-- lua, default settings
require("better_escape").setup {
  mapping = { "kj", "jk", "jj", "kl" }, -- a table with mappings to use
  timeout = vim.o.timeoutlen, -- the time in which the keys must be hit in ms. Use option timeoutlen by default
  clear_empty_lines = false, -- clear line after escaping if there is only whitespace
  keys = function() return vim.api.nvim_win_get_cursor(0)[2] > 1 and "<esc>l" or "<esc>" end,
}

-- INFO: overseer.nvim
vim.api.nvim_create_user_command("OverseerRestartLast", function()
  local overseer = require "overseer"
  local tasks = overseer.list_tasks { recent_first = true }
  if vim.tbl_isempty(tasks) then
    vim.notify("No tasks found", vim.log.levels.WARN)
  else
    overseer.run_action(tasks[1], "restart")
  end
end, {})

vim.keymap.set(
  { "n", "i" },
  ";tr",
  "<Esc><cmd>OverseerQuickAction restart<cr>",
  { noremap = true, desc = "rerun Task." }
)

vim.keymap.set({ "n", "i" }, ";tl", "<Esc><cmd>OverseerRun<cr>", { noremap = true, desc = "List tasks" })
vim.keymap.set(
  { "n", "i" },
  ";tb",
  "<Esc><cmd>OverseerRun just\\ build<cr>",
  { noremap = true, desc = "Run build/default tasks" }
)
vim.keymap.set({ "n", "i" }, ";tq", "<Esc><cmd>OverseerQuickAction<cr>", { noremap = true, desc = "QuickAction Menu" })

return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    opts = {
      window = {
        position = "right",
      },
    },
  },
  {
    "echasnovski/mini.move",
    keys = function(_, keys)
      local plugin = require("lazy.core.config").spec.plugins["mini.move"]
      local opts = require("lazy.core.plugin").values(plugin, "opts", false) -- resolve mini.clue options
      -- Populate the keys based on the user's options
      local mappings = {
        { opts.mappings.line_left, desc = "Move line left" },
        { opts.mappings.line_right, desc = "Move line right" },
        { opts.mappings.line_down, desc = "Move line down" },
        { opts.mappings.line_up, desc = "Move line up" },
        { opts.mappings.left, desc = "Move selection left", mode = "v" },
        { opts.mappings.right, desc = "Move selection right", mode = "v" },
        { opts.mappings.down, desc = "Move selection down", mode = "v" },
        { opts.mappings.up, desc = "Move selection up", mode = "v" },
      }
      mappings = vim.tbl_filter(function(m) return m[1] and #m[1] > 0 end, mappings)
      return vim.list_extend(mappings, keys)
    end,
    opts = {
      mappings = {
        left = "<A-Left>",
        right = "<A-Right>",
        down = "<A-Down>",
        up = "<A-Up>",
        line_left = "<A-Left>",
        line_right = "<A-Right>",
        line_down = "<A-Down>",
        line_up = "<A-Up>",
      },
    },
  },
  {
    "mikavilpas/yazi.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    event = "VeryLazy",
    keys = {
      -- NOTE: First time I realized that We could assign mode in here as well.
      -- Pretty much like vim.keymap.set opts. Maybe that's it under the hood.
      {
        ";-",
        function() require("yazi").yazi() end,
        mode = { "n", "i" },
        desc = "Open the file manager",
      },
      {
        "<leader>-",
        function() require("yazi").yazi() end,
        desc = "Open the file manager",
      },
      {
        ";cw",
        function() require("yazi").yazi() end,
        mode = { "n", "i" },
        desc = "Open the file manager",
      },
      {
        -- Open in the current working directory
        "<leader>cw",
        function() require("yazi").yazi(nil, vim.fn.getcwd()) end,
        desc = "Open the file manager in nvim's working directory",
      },
    },
    ---@type YaziConfig
    opts = {
      open_for_directories = true,

      -- chosen_file_path = "$HOME/tmp/yazi_filechosen",
      events_file_path = "$HOME/tmp/yazi.nvim.events.txt",
    },
  },
}
