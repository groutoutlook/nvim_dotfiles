require("better_escape").setup {
  timeout = vim.o.timeoutlen,
  default_mappings = true,
  mappings = {
    i = {
      j = {
        -- These can all also be functions
        k = "<Esc>",
        j = "<Esc>",
      },
    },
    c = {
      j = {
        k = "<Esc>",
        j = "<Esc>",
      },
    },
    t = {
      j = {
        k = "<Esc>",
        j = "<Esc>",
      },
    },
    v = {
      j = {
        k = "<Esc>",
      },
    },
    s = {
      j = {
        k = "<Esc>",
      },
    },
  },
}

-- INFO: overseer.nvim
-- [overseer.nvim/doc/reference.md at master · stevearc/overseer.nvim](https://github.com/stevearc/overseer.nvim/blob/master/doc/reference.md#run_templateopts-callback)
vim.api.nvim_create_user_command("OverseerRestartLast", function()
  local overseer = require "overseer"
  local tasks = overseer.list_tasks { recent_first = true }
  if vim.tbl_isempty(tasks) then
    vim.notify("No tasks found", vim.log.levels.WARN)
    overseer.run_template { name = "just build" }
  else
    overseer.run_action(tasks[1], "restart")
  end
end, {})

vim.keymap.set({ "n", "i" }, ";tr", "<Esc><cmd>OverseerRestartLast<cr>", { noremap = true, desc = "rerun Task." })
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
    "hiberabyss/readline.nvim",
    lazy = false,
  },
  -- {
  --   "desdic/macrothis.nvim",
  --   opts = {},
  --   keys = {
  --     { "<Leader>kd", function() require("macrothis").delete() end, desc = "delete" },
  --     { "<Leader>ke", function() require("macrothis").edit() end, desc = "edit" },
  --     { "<Leader>kl", function() require("macrothis").load() end, desc = "load" },
  --     { "<Leader>kn", function() require("macrothis").rename() end, desc = "rename" },
  --     { "<Leader>kq", function() require("macrothis").quickfix() end, desc = "run macro on all files in quickfix" },
  --     { "<Leader>kr", function() require("macrothis").run() end, desc = "run macro" },
  --     { "<Leader>ks", function() require("macrothis").save() end, desc = "save" },
  --     { "<Leader>kx", function() require("macrothis").register() end, desc = "edit register" },
  --     {
  --       "<Leader>kp",
  --       function() require("macrothis").copy_register_printable() end,
  --       desc = "Copy register as printable",
  --     },
  --     { "<Leader>km", function() require("macrothis").copy_macro_printable() end, desc = "Copy macro as printable" },
  --   },
  -- },
  {
    "scottmckendry/cyberdream.nvim",
    lazy = false,
    priority = 1000,
  },
  { "rose-pine/neovim", name = "rose-pine" },
}
