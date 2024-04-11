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
-- Neovim env.
-- Vanilla mapping
if vim.loop.os_uname().sysname == "Windows_NT" then
  -- print("Windows_NT env config.")
  -- vim.o.shell = "pwsh.exe"
  vim.cmd([[set shell=pwsh
  set shellcmdflag=-command
  set shellquote=\"
  set shellxquote=]])
else
  -- print("Unix env config.")  
end
-- vim.cmd([[colorscheme sonokai]])
vim.cmd([[set guifont=Iosevka\ Nerd\ Font\ Mono:h12]])

vim.api.nvim_create_user_command("Cppath", function()
    local path = vim.fn.expand("%:p")
    vim.fn.setreg("+", path)
    vim.notify('Copied "' .. path .. '" to the clipboard!')
end, {})

-- Move basic vim mapping to here since I break those keymap beneath them frequently.
vim.cmd([[
colorscheme torte
command -bang Q quit<bang>
command -bang W write<bang>
command -bang WQ wq<bang>
command -bang Wq wq<bang>
command -bang CPPA Cppath
cnoremap cppa Cppath
set conceallevel=2
]])
--Basic Lua
vim.api.nvim_set_keymap('i',';u',"<C-o>u", {noremap = true, silent = true , desc = "Undo Insert Mode" })
vim.api.nvim_set_keymap('i',';r',"<C-o><C-r>", {noremap = true, silent = true , desc = "Redo Insert Mode" })
vim.api.nvim_set_keymap('i',';q',"<cmd>quit<CR>", {noremap = true, silent = true , desc = "Redo Insert Mode" })
vim.api.nvim_set_keymap('i','qqq',"<Esc>", {noremap = true, silent = true , desc = "Escape" })
vim.api.nvim_set_keymap('i','yyy',"<Esc>yy", {noremap = true, silent = true , desc = "Escape and yank" })
vim.api.nvim_set_keymap('t','kkk',"<C-\\><C-n>", {noremap = true, silent = true , desc = "Escape in terminal mode"})
vim.api.nvim_set_keymap('t','jjj',"<C-\\><C-n>", {noremap = true, silent = true , desc = "Escape in terminal mode"})

--Plugin related mapping.
--Heavily related to plugins and astronvim core.
vim.keymap.set({'n','i'},';wq',"<cmd>wqall<CR>", {noremap = true, silent = true , desc = "Write and Quit Insert Mode" })
vim.keymap.set({'n','i'},';wg',"<cmd>wall!<CR><cmd>ToggleTerm<cr><cmd>startinsert<cr>git cij<cr>", {noremap = true, silent = true , desc = "Write and git Insert Mode" })
vim.keymap.set({'n','i'},';wt',"<cmd>wall!<CR><cmd>ToggleTerm<cr><cmd>startinsert<cr>lsd<cr>", {noremap = true, silent = true , desc = "Write and Term Insert Mode" })
vim.keymap.set({'n','i'},';ww',"<cmd>wall!<CR><cmd>lua require('resession').save()<cr>", {noremap = true, silent = true , desc = "Write and Save session" })

-- TODO: check if there is more todo, 
-- Now it's on the telescope.lua custom files.

