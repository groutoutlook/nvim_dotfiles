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

return {}
