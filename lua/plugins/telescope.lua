-- Mapping for telescope, since I tweaking with it quite a lot.
local tl = require "telescope"
local tl_b = require "telescope.builtin"
vim.keymap.set({ "n", "i" }, ";ft", "<cmd>TodoTelescope<cr>", { noremap = true, desc = "find TODO FIXME BUG etc.." })

vim.keymap.set(
  { "n", "i" },
  ";fn",
  function() tl.extensions.notify.notify() end,
  { noremap = true, desc = "find notifications" }
)

local function live_grep_or_grep_string(opts)
  local currentWord = opts
  if currentWord == nil then
    tl_b.live_grep()
  else
    tl_b.grep_string()
  end
end
vim.keymap.set({ "n", "i" }, ";ff", function() live_grep_or_grep_string() end, { noremap = true, desc = "find word" })
vim.keymap.set(
  { "n", "i" },
  ";fw",
  function() live_grep_or_grep_string "grep" end,
  { noremap = true, desc = "find notifications" }
)
vim.keymap.set(
  { "n", "i" },
  ";fF",
  function() tl_b.find_files { hidden = true, layout_config = { prompt_position = "top" } } end,
  { noremap = true, desc = "find All Files" }
)

vim.keymap.set(
  { "n", "i" },
  ";FF",
  function() tl_b.find_files { hidden = true, layout_config = { prompt_position = "top" } } end,
  { noremap = true, desc = "find All Files" }
)
vim.keymap.set(
  { "n", "i" },
  ";fb",
  function() tl_b.buffers() end,
  { noremap = true, silent = true, desc = "check buffers." }
)
--
vim.keymap.set({ "n", "i" }, ";fu", "<cmd>Telescope undo<cr>", { noremap = true, desc = "Telescope Undo " })
vim.keymap.set(
  { "n", "i" },
  ";fy",
  "<cmd>Telescope yank_history<cr>",
  { noremap = true, desc = "Telescope Yanky.nvim" }
)

vim.keymap.set({ "n", "i" }, ";fr", "<cmd>Telescope registers<cr>", { noremap = true, desc = "Telescope Yanky.nvim" })

vim.keymap.set({ "n", "i" }, ";fk", "<cmd>Telescope keymaps<cr>", { noremap = true, desc = "Telescope Yanky.nvim" })

vim.keymap.set(
  { "n", "i" },
  ";f'",
  "<cmd>Telescope marks<cr>",
  { noremap = true, silent = true, desc = "diagnostics Telescope" }
)

vim.keymap.set(
  { "n", "i" },
  ";fo",
  function() tl_b.oldfiles() end,
  { noremap = true, silent = true, desc = "Open oldfiles." }
)

-- INFO: LSP toggle.
-- WARN: If cant find keymap easily, just launch straight into the astronvim site to find keymap.
-- [](https://github.com/search?q=repo%3AAstroNvim%2FAstroNvim+lD&type=code)
vim.keymap.set(
  { "n", "i" },
  ";gt",
  "<cmd>Telescope git_status<cr>",
  { noremap = true, silent = true, desc = "Write and Git Insert Mode" }
)

vim.keymap.set(
  { "n", "i" },
  ";gr",
  function() require("gitsigns").reset_hunk() end,
  { noremap = true, silent = true, desc = "restore git hunk" }
)

vim.keymap.set(
  { "n", "i" },
  ";gp",
  function() require("gitsigns").preview_hunk_inline() end,
  { noremap = true, silent = true, desc = "Preview git hunk." }
)

vim.keymap.set(
  { "n", "i" },
  ";gb",
  "<cmd>Telescope git_branches<cr>",
  { noremap = true, silent = true, desc = "Write and Git Insert Mode" }
)

vim.keymap.set(
  { "n", "i" },
  ";ld",
  function() tl_b.diagnostics() end,
  { noremap = true, silent = true, desc = "diagnostics Telescope" }
)

vim.keymap.set({ "n", "i" }, ";ls", function()
  -- require("aerial").toggle()
  -- vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("/", true, true, true), "in", true)
  -- tl.load_extension "aerial"
  vim.cmd "Telescope aerial"
end, { noremap = true, silent = true, desc = "diagnostics Telescope" })

return {}
