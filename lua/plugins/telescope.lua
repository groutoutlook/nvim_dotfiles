-- Mapping for telescope, since I tweaking with it quite a lot.
vim.keymap.set({ "n", "i" }, ";ft", "<cmd>TodoTelescope<cr>", { noremap = true, desc = "find TODO FIXME BUG etc.." })

vim.keymap.set(
  { "n", "i" },
  ";fn",
  function() require("telescope").extensions.notify.notify() end,

  { noremap = true, desc = "find notifications" }
)
vim.keymap.set(
  { "n", "i" },
  ";fw",
  function() require("telescope.builtin").live_grep() end,
  { noremap = true, desc = "find notifications" }
)
vim.keymap.set(
  { "n", "i" },
  ";ff",
  function() require("telescope.builtin").live_grep() end,
  { noremap = true, desc = "find word" }
)
vim.keymap.set(
  { "n", "i" },
  ";fF",
  function() require("telescope.builtin").find_files { hidden = true, layout_config = { prompt_position = "top" } } end,
  { noremap = true, desc = "find All Files" }
)
vim.keymap.set(
  { "n", "i" },
  ";fb",
  function() require("telescope.builtin").buffers() end,
  { noremap = true, silent = true, desc = "Redo Insert Mode" }
)

vim.keymap.set({ "n", "i" }, ";fu", "<cmd>Telescope undo<cr>", { noremap = true, desc = "Telescope Undo " })
vim.keymap.set(
  { "n", "i" },
  ";fy",
  "<cmd>Telescope yank_history<cr>",
  { noremap = true, desc = "Telescope Yanky.nvim" }
)

vim.keymap.set(
  { "n", "i" },
  ";f'",
  "<cmd>Telescope marks<cr>",
  { noremap = true, silent = true, desc = "diagnostics Telescope" }
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
  ";ld",
  function() require("telescope.builtin").diagnostics() end,
  { noremap = true, silent = true, desc = "diagnostics Telescope" }
)

vim.keymap.set(
  { "n", "i" },
  ";ls",
  function() require("aerial").toggle() end,
  { noremap = true, silent = true, desc = "diagnostics Telescope" }
)

return {}
