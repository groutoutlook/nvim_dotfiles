--Keymapping and keybinding only files.
vim.api.nvim_set_keymap("i", "qq", "<Esc>", { noremap = true, silent = true, desc = "Escape." })
vim.api.nvim_set_keymap("i", "yyy", "<Esc>yy", { noremap = true, silent = true, desc = "Escape and yank." })
vim.api.nvim_set_keymap("i", "ddd", "<Esc>dd", { noremap = true, silent = true, desc = "Escape and delete line." })
vim.api.nvim_set_keymap("i", "vvv", "<Esc>v$", { noremap = true, silent = true, desc = "Escape and Visual line." })
vim.api.nvim_set_keymap("n", "<leader>v", "v$", { noremap = true, silent = true, desc = "Escape and Visual line." })
vim.api.nvim_set_keymap("v", "vv", "$", { noremap = true, silent = true, desc = "Escape and Visual line." })

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

if vim.fn.has "gui_running" then
  vim.keymap.set("c", "<M-p>", "<C-r>+", { noremap = true, silent = true, desc = "Paste in Command Line" })
  vim.keymap.set("c", "<C-v>", "<C-r>+", { noremap = true, silent = true, desc = "Paste in Command Line" })
  vim.keymap.set("c", "<S-Insert>", "<C-r>+", { noremap = true, silent = true, desc = "Write and Quit Insert Mode" })
else
  vim.keymap.set("c", "<M-p>", "<C-r>+", { noremap = true, silent = true, desc = "Paste in Command Line" })
end
--Plugin related mapping.
--Heavily related to plugins and astronvim core.
vim.keymap.set({ "n", "i" }, ";q", "<cmd>quitall!<CR>", { noremap = true, silent = true, desc = "Quit" })
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
vim.keymap.set({ "n", "i" }, ";u", "<C-o>u", { noremap = true, silent = true, desc = "Undo Insert Mode" })
vim.keymap.set({ "n", "i" }, ";r", "<C-o><C-r>", { noremap = true, silent = true, desc = "Redo Insert Mode" })
if (vim.fn.has "win32") or (vim.fn.has "macunix") then
  vim.keymap.set(
    { "n", "i" },
    ";ls",
    "<cmd>wall!<CR><esc><cmd>ToggleTerm<cr>lsd<cr>:vs g<cr><cmd>ToggleTerm<cr>", -- <cmd>colorscheme default<cr>",
    { noremap = true, silent = true, desc = "Launch GUI(Neovide)" }
  )
  vim.keymap.set(
    { "n", "i" },
    ";lg",
    "<cmd>wall!<CR><esc><cmd>ToggleTerm<cr>lsd<cr>:vl g<cr><cmd>ToggleTerm<cr>", -- <cmd>colorscheme default<cr>",
    { noremap = true, silent = true, desc = "Launch GUI(Neovide)" }
  )
else
  vim.keymap.set(
    { "n", "i" },
    ";lg",
    "<cmd>wall!<CR><esc><cmd>ToggleTerm<cr>lsd<cr>are you sure you have the GUI?<cr>",
    { noremap = true, silent = true, desc = "Launch GUI(Neovide) but Linux may not have the GUI" }
  )
end
-- TODO: check if there is more todo,
-- Now it's on the telescope.lua custom files.
--
vim.keymap.set(
  { "n", "i" },
  ";gci",
  "<cmd>wall!<CR><esc><cmd>ToggleTerm<cr>lsd<cr>git cij<cr>",
  { noremap = true, silent = true, desc = "Write and Git Insert Mode" }
)

vim.keymap.set({ "n", "i" }, ";gx", "<cmd>normal gx<cr>", { noremap = true, silent = true, desc = "Open Scheme Link." })
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
vim.keymap.set(
  { "n", "i" },
  ";ee",
  "<esc><cmd>ToggleTerm<cr>lsd<cr>:e e<cr>",
  { noremap = true, desc = "Google (ready) in ToggleTerm " }
)

require("leap.user").set_repeat_keys("<enter>", "<backspace>", {
  -- False by default. If set to true, the keys will work like the
  -- native semicolon/comma, i.e., forward/backward is understood in
  -- relation to the last motion.
  relative_directions = true,
  -- By default, all modes are included.
  modes = { "n", "x", "o" },
})

vim.keymap.set({ "i" }, ";s", "<C-o><Plug>(leap)", { noremap = true, desc = "Leap" })
vim.keymap.set({ "n" }, "s", "<Plug>(leap)", { noremap = true, desc = "Leap" })
vim.keymap.set({ "i" }, ";S", "<C-o><Plug>(leap-backward-to)", { noremap = true, desc = "Leap" })
vim.keymap.set({ "i" }, ";gs", "<C-o><Plug>(leap-from-window)", { noremap = true, desc = "Leap" })
vim.keymap.set({ "n" }, "s", "<Plug>(leap)", { noremap = true, desc = "Leap" })
vim.keymap.set({ "n" }, ";gs", "<Plug>(leap-from-window)", { noremap = true, desc = "Leap" })
-- Jumping window
vim.keymap.set(
  { "n" },
  "<leader>ww",
  "<cmd>lua require('nvim-window').pick()<cr>",
  { noremap = true, desc = "nvim-window: Jump to window" }
)
vim.keymap.set(
  { "n", "i" },
  ";wj",
  "<cmd>lua require('nvim-window').pick()<cr>",
  { noremap = true, desc = "nvim-window: Jump to window" }
)

-- Pane vanilla
-- WARN: HACKY way to do it, also in old Vim API... Need to rewrite some day,
-- but not that urgent though.
local function quitWindow() vim.cmd["quit"]() end
local function evenWindow()
  -- One small behaviour here it I'm not sure if this work globally
  -- or just work in an area of splitted panes instead.
  vim.cmd["vsplit"]()
  vim.cmd["quit"]()
  vim.cmd["split"]()
  vim.cmd["quit"]()
end
-- See! Emacs key binding.
vim.keymap.set(
  { "n", "i" },
  "<c-w><c-q>",
  function() quitWindow() end,
  { noremap = true, desc = "nvim-window: Jump to window" }
)
vim.keymap.set(
  { "n", "i" },
  "<c-w><c-e>",
  function() evenWindow() end,
  { noremap = true, desc = "nvim-window: Jump to window" }
)

vim.keymap.set({ "n", "i" }, "<c-w><c-=>", "<esc><C-w>=", { noremap = true, desc = "nvim-window: Jump to window" })

-- NOTE: try note tag...
-- Undo history. It will take quite some time though, lagging.
vim.keymap.set({ "n", "i" }, ";fu", "<cmd>Telescope undo<cr>", { noremap = true, desc = "Telescope Undo " })
vim.keymap.set(
  { "n", "i" },
  ";fy",
  "<cmd>Telescope yank_history<cr>",
  { noremap = true, desc = "Telescope Yanky.nvim" }
)

return {}
