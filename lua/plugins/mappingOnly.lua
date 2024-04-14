--Keymapping and keybinding only files.
vim.api.nvim_set_keymap("i", ";u", "<C-o>u", { noremap = true, silent = true, desc = "Undo Insert Mode" })
vim.api.nvim_set_keymap("i", ";r", "<C-o><C-r>", { noremap = true, silent = true, desc = "Redo Insert Mode" })
vim.api.nvim_set_keymap("i", ";q", "<cmd>quit<CR>", { noremap = true, silent = true, desc = "Redo Insert Mode" })
vim.api.nvim_set_keymap("i", "qq", "<Esc>", { noremap = true, silent = true, desc = "Escape." })
vim.api.nvim_set_keymap("i", "yyy", "<Esc>yy", { noremap = true, silent = true, desc = "Escape and yank." })
vim.api.nvim_set_keymap("i", "ddd", "<Esc>dd", { noremap = true, silent = true, desc = "Escape and delete line." })
vim.api.nvim_set_keymap("i", "vvv", "<Esc>v$", { noremap = true, silent = true, desc = "Escape and Visual line." })
vim.api.nvim_set_keymap("n", "<leader>v", "v$", { noremap = true, silent = true, desc = "Escape and Visual line." })
vim.api.nvim_set_keymap("v", "vv", "$", { noremap = true, silent = true, desc = "Escape and Visual line." })
vim.api.nvim_set_keymap("v", "jk", "<Esc>", { noremap = true, silent = true, desc = "Escape Visual mode." })
vim.api.nvim_set_keymap(
  "c",
  "qqq",
  "<cr><cmd>redraw!<cr>",
  { noremap = true, silent = true, desc = "Escape Command mode." }
)
vim.api.nvim_set_keymap(
  "c",
  "jk",
  "<cr><cmd>redraw!<cr>",
  { noremap = true, silent = true, desc = "Escape Command mode." }
)
vim.api.nvim_set_keymap(
  "t",
  "qqq",
  "<C-\\><C-n>",
  { noremap = true, silent = true, desc = "Normal mode from Terminal mode" }
)
vim.api.nvim_set_keymap(
  "t",
  "qqi",
  "<Esc>i",
  { noremap = true, silent = true, desc = "Escape and insert in Terminal mode" }
)
vim.api.nvim_set_keymap(
  "t",
  "qqa",
  "<Esc>i",
  { noremap = true, silent = true, desc = "Escape and insert in Terminal mode" }
)
vim.api.nvim_set_keymap(
  "t",
  "qqa",
  "<Esc>i",
  { noremap = true, silent = true, desc = "Escape and insert in Terminal mode" }
)

--Plugin related mapping.
--Heavily related to plugins and astronvim core.
vim.keymap.set(
  { "n", "i" },
  ";wq",
  "<cmd>wqall!<CR>",
  { noremap = true, silent = true, desc = "Write and Quit Insert Mode" }
)
vim.keymap.set(
  { "n", "i" },
  ";wg",
  "<cmd>wall!<CR><esc><cmd>ToggleTerm<cr>lsd<cr>git cij<cr>",
  { noremap = true, silent = true, desc = "Write and git Insert Mode" }
)

vim.keymap.set(
  { "n", "i" },
  ";wt",
  "<esc><cmd>ToggleTerm<cr>lsd<cr><cmd>wall<CR>",
  { noremap = true, silent = true, desc = "Write and Term Insert Mode" }
)
vim.keymap.set(
  { "n", "i" },
  ";ws",
  "<cmd>wall!<CR><cmd>lua require('resession').save()<cr>",

  { noremap = true, silent = true, desc = "Write and Save session" }
)
-- TODO: check if there is more todo,
-- Now it's on the telescope.lua custom files.
--

vim.keymap.set(
  { "n", "i" },
  ";/",
  function() require("Comment.api").toggle.linewise.count(vim.v.count1) end,
  { noremap = true, desc = "Comment the line in Insert Mode" }
)
vim.keymap.set({ "n", "i" }, ";tt", "<esc><cmd>ToggleTerm<cr>lsd<cr>", { noremap = true, desc = "Simply ToggleTerm" })
vim.keymap.set(
  { "n", "i" },
  ";cst",
  "<esc><cmd>ToggleTerm<cr>lsd<cr>cst<cr>",
  { noremap = true, desc = "CodeStat in ToggleTerm" }
)
vim.keymap.set(
  { "n", "i" },
  ";jj",
  "<esc><cmd>ToggleTerm<cr>lsd<cr>j<space>",
  { noremap = true, desc = "Journal (ready) in ToggleTerm" }
)
vim.keymap.set(
  { "n", "i" },
  ";oo",
  "<esc><cmd>ToggleTerm<cr>lsd<cr>:o<space>",
  { noremap = true, desc = "Obsidian (ready) in ToggleTerm " }
)
vim.keymap.set(
  { "n", "i" },
  ";gg",
  "<esc><cmd>ToggleTerm<cr>lsd<cr>gg<space>",
  { noremap = true, desc = "Google (ready) in ToggleTerm " }
)
return {}
