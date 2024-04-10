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



vim.api.nvim_set_keymap('i',';wt',"<cmd>wall<CR><cmd>ToggleTerm<cr><Esc>", {noremap = true, silent = true , desc = "Write and Term Insert Mode" })
vim.api.nvim_set_keymap('i',';wq',"<cmd>wqall<CR>", {noremap = true, silent = true , desc = "Write and Quit Insert Mode" })
vim.api.nvim_set_keymap('i',';u',"<C-o>u", {noremap = true, silent = true , desc = "Undo Insert Mode" })
vim.api.nvim_set_keymap('i',';r',"<C-o><C-r>", {noremap = true, silent = true , desc = "Redo Insert Mode" })
vim.api.nvim_set_keymap('i',';q',"<cmd>quit<CR>", {noremap = true, silent = true , desc = "Redo Insert Mode" })
vim.api.nvim_set_keymap('i','qqq',"<Esc>", {noremap = true, silent = true , desc = "Escape" })
vim.api.nvim_set_keymap('n',';wt',"<cmd>wall<CR><cmd>ToggleTerm<cr>", {noremap = true, silent = true , desc = "Write and Term Normal Mode" })
vim.api.nvim_set_keymap('n',';wq',"<cmd>wqall<cr>", {noremap = true, silent = true , desc = "Write and Term Normal Mode" })
vim.api.nvim_set_keymap('c','wt',"wall<CR><cmd>ToggleTerm<cr>", {noremap = true, silent = true , desc = "Write and Toggle terminal" })
-- Keymap set.
vim.keymap.set('i',';fb',function() require("telescope.builtin").buffers() end , {noremap = true, silent = true , desc = "Redo Insert Mode" })
vim.keymap.set('n',';fb',function() require("telescope.builtin").buffers() end, {noremap = true, silent = true , desc = "Redo Insert Mode" })

vim.keymap.set('n',"<Leader>fs",function() require("resession").load() end,{noremap = true, desc = "Load last session" })
vim.keymap.set('n',"<Leader>fl",function() require("resession").load() end,{noremap = true, desc = "Load last session" })
vim.keymap.set('n',"<Leader>..",function() require("resession").load(vim.fn.getcwd(), { dir = "dirsession" }) end,{noremap = true, desc = "Load last session" })


vim.cmd([[
colorscheme torte
command -bang Q quit<bang>
command -bang W write<bang>
command -bang WQ wq<bang>
command -bang Wq wq<bang>
command -bang CPPA Cppath
command Cppa Cppath
]])
