-- This file simply bootstraps the installation of Lazy.nvim and then calls other files for execution
-- This file doesn't necessarily need to be touched, BE CAUTIOUS editing this file and proceed at your own risk.
local lazypath = vim.env.LAZY or vim.fn.stdpath "data" .. "/lazy/lazy.nvim"
if not (vim.env.LAZY or (vim.uv or vim.loop).fs_stat(lazypath)) then
  -- stylua: ignore
  vim.fn.system({ "git", "clone", "--filter=blob:none", "https://github.com/folke/lazy.nvim.git", "--branch=stable", lazypath })
end
vim.opt.rtp:prepend(lazypath)

-- validate that lazy is available
if not pcall(require, "lazy") then
  -- stylua: ignore
  vim.api.nvim_echo({ { ("Unable to load lazy from: %s\n"):format(lazypath), "ErrorMsg" }, { "Press any key to exit...", "MoreMsg" } }, true, {})
  vim.fn.getchar()
  vim.cmd.quit()
end
require "lazy_setup"
require "polish"
vim.cmd [[
colorscheme torte
command -bang Q quit<bang>
command -bang W write<bang>
command -bang WQ wq<bang>
command -bang Wq wq<bang>
]]
-- vim settings.
vim.cmd [[
set guifont=Iosevka\ Nerd\ Font\ Mono:h10
set conceallevel=2
colorscheme torte
]]

--Basic Lua
vim.api.nvim_set_keymap("i", ";u", "<C-o>u", { noremap = true, silent = true, desc = "Undo Insert Mode" })
vim.api.nvim_set_keymap("i", ";r", "<C-o><C-r>", { noremap = true, silent = true, desc = "Redo Insert Mode" })
vim.api.nvim_set_keymap("i", ";q", "<cmd>quit<CR>", { noremap = true, silent = true, desc = "Redo Insert Mode" })
vim.api.nvim_set_keymap("i", "qq", "<Esc>", { noremap = true, silent = true, desc = "Escape." })
vim.api.nvim_set_keymap("i", "yyy", "<Esc>yy", { noremap = true, silent = true, desc = "Escape and yank." })
vim.api.nvim_set_keymap("i", "ddd", "<Esc>dd", { noremap = true, silent = true, desc = "Escape and delete line." })
vim.api.nvim_set_keymap("i", "vvv", "<Esc>v$", { noremap = true, silent = true, desc = "Escape and Visual line." })
vim.api.nvim_set_keymap("t", "qqq", "<C-\\><C-n>", { noremap = true, silent = true, desc = "Normal mode from Terminal mode" })
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
  "<cmd>wqall<CR>",
  { noremap = true, silent = true, desc = "Write and Quit Insert Mode" }
)
vim.keymap.set(
  { "n", "i" },
  ";wg",
  "<cmd>ToggleTerm<cr>lsd<cr>git cij<cr><cmd>wall<CR>",
  { noremap = true, silent = true, desc = "Write and git Insert Mode" }
)

vim.keymap.set(
  { "n", "i" },
  ";wt",
  "<cmd>ToggleTerm<cr>lsd<cr><cmd>wall<CR>",
  { noremap = true, silent = true, desc = "Write and Term Insert Mode" }
)
vim.keymap.set(
  { "n", "i" },
  ";ww",
  "<cmd>wall<CR><cmd>lua require('resession').save()<cr>",
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
vim.keymap.set(
  { "n", "i" },
  ";cst",
  "<cmd>ToggleTerm<cr>lsd<cr>cst<cr>",
  { noremap = true, desc = "CodeStat in ToggleTerm" }
)
vim.keymap.set(
  { "n", "i" },
  ";tj",
  "<cmd>ToggleTerm<cr>lsd<cr>j<space>",
  { noremap = true, desc = "Journal (ready) in ToggleTerm" }
)
vim.keymap.set(
  { "n", "i" },
  ";to",
  "<cmd>ToggleTerm<cr>lsd<cr>obs<space>",
  { noremap = true, desc = "Obsidian (ready) in ToggleTerm " }
)
