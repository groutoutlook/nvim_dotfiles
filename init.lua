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

-- vim settings.
vim.cmd([[
set guifont=Iosevka\ Nerd\ Font\ Mono:h12
set conceallevel=2
]])

local colorscheme = "torte"
local ok, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)
vim.o.background = "dark" -- or "light" for light mode
if not ok then
  vim.notify("colorscheme " .. colorscheme .. " not found!")
  return
end

--Basic Lua
vim.api.nvim_set_keymap('i',';u',"<C-o>u", {noremap = true, silent = true , desc = "Undo Insert Mode" })
vim.api.nvim_set_keymap('i',';r',"<C-o><C-r>", {noremap = true, silent = true , desc = "Redo Insert Mode" })
vim.api.nvim_set_keymap('i',';q',"<cmd>quit<CR>", {noremap = true, silent = true , desc = "Redo Insert Mode" })
vim.api.nvim_set_keymap('i','qq',"<Esc>", {noremap = true, silent = true , desc = "Escape." })
vim.api.nvim_set_keymap('i','yyy',"<Esc>yy", {noremap = true, silent = true , desc = "Escape and yank." })
vim.api.nvim_set_keymap('i','ddd',"<Esc>dd", {noremap = true, silent = true , desc = "Escape and delete line." })
vim.api.nvim_set_keymap('i','vvv',"<Esc>v$", {noremap = true, silent = true , desc = "Escape and Visual line." })
vim.api.nvim_set_keymap('t','qqq',"<C-\\><C-n>", {noremap = true, silent = true , desc = "Escape in terminal mode"})

--Plugin related mapping.
--Heavily related to plugins and astronvim core.
vim.keymap.set({'n','i'},';wq',"<cmd>wqall<CR>", {noremap = true, silent = true , desc = "Write and Quit Insert Mode" })
vim.keymap.set({'n','i'},';wg',"<cmd>ToggleTerm<cr><cmd>startinsert<cr>lsd<cr>git cij<cr><cmd>wall<CR>", {noremap = true, silent = true , desc = "Write and git Insert Mode" })
vim.keymap.set({'n','i'},';wt',"<cmd>ToggleTerm<cr><cmd>startinsert<cr>lsd<cr><cmd>wall<CR>", {noremap = true, silent = true , desc = "Write and Term Insert Mode" })
vim.keymap.set({'n','i'},';ww',"<cmd>wall<CR><cmd>lua require('resession').save()<cr>", {noremap = true, silent = true , desc = "Write and Save session" })

-- TODO: check if there is more todo, 
-- Now it's on the telescope.lua custom files.
vim.keymap.set({'n','i'},";/",function() require("Comment.api").toggle.linewise.count(vim.v.count1) end,{noremap = true, desc = "Comment the line in Insert Mode" })
