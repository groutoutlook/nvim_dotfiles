-- nvim-window for hinting windows
-- lua, default settings
require("better_escape").setup {
  mapping = { "jk", "jj" }, -- a table with mappings to use
  timeout = vim.o.timeoutlen, -- the time in which the keys must be hit in ms. Use option timeoutlen by default
  clear_empty_lines = false, -- clear line after escaping if there is only whitespace
  keys = "<Esc>", -- keys used for escaping, if it is a function will use the result everytime
  -- example(recommended)
  -- keys = function()
  --   return vim.api.nvim_win_get_cursor(0)[2] > 1 and '<esc>l' or '<esc>'
  -- end,
}
return {
  {
    "yorickpeterse/nvim-window",
    keys = {
      { "<leader>wj", "<cmd>lua require('nvim-window').pick()<cr>", desc = "nvim-window: Jump to window" },
    },
    config = true,
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
    "catppuccin/nvim",
    optional = true,
    ---@type CatppuccinOptions
    opts = { integrations = { mini = true } },
  },
}
