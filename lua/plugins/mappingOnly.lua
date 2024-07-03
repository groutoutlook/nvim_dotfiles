-- INFO: Keymapping and keybinding only files.
vim.api.nvim_set_keymap("i", "qq", "<Esc>", { noremap = true, silent = true, desc = "Escape." })
vim.api.nvim_set_keymap("v", "vv", "$", { noremap = true, silent = true, desc = "Escape and Visual line." })

-- Navigation easy
vim.api.nvim_set_keymap("n", "GG", "Gzz", { noremap = true, silent = true, desc = "Center Final line." })

-- INFO: Editting abilities, mostly alias the `ci*` bracket things.

vim.keymap.set(
  { "n", "i" },
  "ci9",
  "<Esc>ci(",
  { noremap = true, silent = true, desc = "Edit: change in parentheses." }
)
vim.keymap.set({ "n", "i" }, "yi9", "<Esc>yi(", { noremap = true, silent = true, desc = "Edit: yank in parentheses." })

vim.keymap.set(
  { "n", "i" },
  "ci;",
  '<Esc>ci"',
  { noremap = true, silent = true, desc = "Edit: change in parentheses." }
)

vim.keymap.set({ "n", "i" }, "yi;", '<Esc>yi"', { noremap = true, silent = true, desc = "Edit: yank in parentheses." })

-- INFO: Terminal navigation keymode.
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
  vim.keymap.set(
    { "c", "n", "i" },
    "<S-Insert>",
    "<C-r>+",
    { noremap = true, silent = true, desc = "Write and Quit Insert Mode" }
  )
else
  vim.keymap.set("c", "<M-p>", "<C-r>+", { noremap = true, silent = true, desc = "Paste in Command Line" })
end
--Plugin related mapping.
--Heavily related to plugins and astronvim core.
vim.keymap.set({ "n", "i" }, ";q", "<cmd>quitall!<CR>", { noremap = true, silent = true, desc = "Quit" })

vim.keymap.set(
  { "n", "i" },
  ";wq",
  "<cmd>wq!<CR>",
  { noremap = true, silent = true, desc = "Write and Quit Insert Mode" }
)

vim.keymap.set(
  { "n", "i" },
  ";wg",
  "<cmd>wall!<CR><esc><cmd>ToggleTerm<cr>git cij<cr>",
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

vim.keymap.set(
  { "n", "i" },
  ";wS",
  "<cmd>wall!<CR>:Savess",
  { noremap = true, silent = true, desc = "Prompt to Save." }
)

-- vim.keymap.set({ "n", "i" }, ";u", "<C-o>u", { noremap = true, silent = true, desc = "Undo Insert Mode" })
vim.keymap.set({ "n", "i" }, ";r", "<C-o><C-r>", { noremap = true, silent = true, desc = "Redo Insert Mode" })
if (vim.fn.has "win32") or (vim.fn.has "macunix") then
  vim.keymap.set(
    { "n", "i" },
    ";lg",
    "<cmd>wall!<CR><esc><cmd>ToggleTerm<cr>:vl g<cr><cmd>ToggleTerm<cr>", -- <cmd>colorscheme default<cr>",
    { noremap = true, silent = true, desc = "Launch GUI(Neovide)" }
  )
else
  vim.keymap.set(
    { "n", "i" },
    ";lg",
    "<cmd>wall!<CR><esc><cmd>ToggleTerm<cr>are you sure you have the GUI?<cr>",
    { noremap = true, silent = true, desc = "Launch GUI(Neovide) but Linux may not have the GUI" }
  )
end
-- TODO: check if there is more todo,
-- Now it's on the telescope.lua custom files.
--
vim.keymap.set(
  { "n", "i" },
  ";gc",
  "<cmd>wall!<CR><esc><cmd>ToggleTerm<cr>git cij<cr>",
  { noremap = true, silent = true, desc = "Write and Git Insert Mode" }
)

vim.keymap.set(
  { "n", "i" },
  ";gx",
  '<Esc>f(w<cmd>lua vim.ui.open(vim.fn.expand("<cfile>"))<cr>',
  { desc = "Open Scheme Link at the end of line.", noremap = false }
)
vim.keymap.set(
  { "i" },
  "gxx",
  '<Esc>f(w<cmd>lua vim.ui.open(vim.fn.expand("<cfile>"))<cr>',
  { desc = "Open Scheme Link at the end of line.", noremap = false }
)
vim.keymap.set(
  { "n", "i" },
  "<C-cr>",
  '<Esc>f(w<cmd>lua vim.ui.open(vim.fn.expand("<cfile>"))<cr>',
  { desc = "Open Scheme Link at the end of line.", noremap = false }
)

vim.keymap.set(
  { "n", "i" },
  ";/",
  function() require("Comment.api").toggle.linewise.count(vim.v.count1) end,
  { noremap = true, desc = "Comment the line in Insert Mode" }
)

vim.keymap.set({ "n", "i" }, ";tt", "<esc><cmd>ToggleTerm<cr>lsd<cr>", { noremap = true, desc = "Simply ToggleTerm" })

vim.keymap.set(
  { "n", "i" },
  ";jj",
  "<esc><cmd>ToggleTerm<cr>j<space>",
  { noremap = true, desc = "Journal (ready) in ToggleTerm" }
)
vim.keymap.set(
  { "n", "i" },
  ";oo",
  "<esc><cmd>ToggleTerm<cr>:o<space>",
  { noremap = true, desc = "Obsidian (ready) in ToggleTerm " }
)
vim.keymap.set(
  { "n", "i" },
  ";oi",
  "<esc><cmd>ToggleTerm<cr>obs <cr>",
  { noremap = true, desc = "Obsidian (ready) in ToggleTerm " }
)
vim.keymap.set(
  { "n", "i" },
  ";gg",
  "<esc><cmd>ToggleTerm<cr>gg<space>",
  { noremap = true, desc = "Google (ready) in ToggleTerm " }
)
vim.keymap.set(
  { "n", "i" },
  ";ee",
  "<esc><cmd>ToggleTerm<cr>:e e<cr>",
  { noremap = true, desc = "Espanso in ToggleTerm " }
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
  { "n" },
  "<c-w><c-q>",
  function() quitWindow() end,
  { noremap = true, desc = "nvim-window: Jump to window" }
)
vim.keymap.set(
  { "n" },
  "<c-w><c-e>",
  function() evenWindow() end,
  { noremap = true, desc = "nvim-window: Jump to window" }
)
vim.keymap.set({ "n", "v" }, "<c-w><c-=>", "<esc><C-w>=", { noremap = true, desc = "Even panes." })

vim.keymap.set({ "n", "i" }, ";bb", function()
  require("astroui.status.heirline").buffer_picker(function(bufnr) vim.api.nvim_win_set_buf(0, bufnr) end)
end, { noremap = true, desc = "Telescope Yanky.nvim" })

-- INFO: Toggling UI/UX functions.
vim.keymap.set(
  { "n", "i" },
  ";ud",
  function() require("astrocore.toggles").diagnostics() end,
  { desc = "Toggle diagnostics" }
)
vim.keymap.set({ "n", "i" }, ";us", function() require("astrocore.toggles").spell() end, { desc = "Toggle spellcheck" })
vim.keymap.set({ "n", "i" }, ";ut", function() require("astrocore.toggles").tabline() end, { desc = "Toggle tabline" })
vim.keymap.set(
  { "n", "i" },
  ";ul",
  function() require("astrocore.toggles").statusline() end,
  { desc = "Toggle statusline" }
)

vim.keymap.set(
  { "n", "i" },
  ";un",
  function() require("astrocore.toggles").notifications() end,
  { desc = "Toggle notifications" }
)

-- INFO: Mimic my `powershell` windows terminal behaviour.
vim.keymap.set({ "i" }, "<C-BS>", "<C-W>", { desc = "delete backward" })
vim.keymap.set({ "n" }, "<C-BS>", "i<C-W><Esc>", { desc = "delete backward" })
vim.keymap.set({ "n" }, "<M-d>", "i<C-W><Esc>", { desc = "delete backward" })

local kopts = { noremap = true, silent = true, desc = "escape search mode for hlslens" }
-- nvim-hlslens to stop search.
-- The original issue here is `<leader>l` is already assigned.
vim.api.nvim_set_keymap("n", ";n", "<Cmd>noh<CR>", kopts)
vim.api.nvim_set_keymap("n", ";<Esc>", "<Cmd>noh<CR>", kopts)

require("leap.user").set_repeat_keys("<enter>", "<backspace>", {
  -- False by default. If set to true, the keys will work like the
  -- native semicolon/comma, i.e., forward/backward is understood in
  -- relation to the last motion.
  relative_directions = true,
  -- By default, all modes are included.
  modes = { "n", "x", "o" },
})

return {}
