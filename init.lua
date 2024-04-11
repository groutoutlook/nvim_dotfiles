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
vim.keymap.set({'n','i'},';wf',"<cmd>wall<CR><cmd>lua require('resession').load()<cr>", {noremap = true, silent = true , desc = "Write and Load session" })
vim.keymap.set({'n','i'},';wl',"<cmd>wall<CR><cmd>lua require('resession').load()<cr>", {noremap = true, silent = true , desc = "Write and Load session" })
vim.keymap.set({'n','i'},';wg',"<cmd>wall<CR><cmd>ToggleTerm<cr><cmd>startinsert<cr><cmd>call feedkeys(\"git cij\")<cr>", {noremap = true, silent = true , desc = "Write and Term Insert Mode" })
vim.keymap.set({'n','i'},';wt',"<cmd>wall<CR><cmd>ToggleTerm<cr>", {noremap = true, silent = true , desc = "Write and Term Insert Mode" })
vim.keymap.set({'n','i'},';ww',"<cmd>wall<CR><cmd>lua require('resession').save()<cr>", {noremap = true, silent = true , desc = "Write and Save session" })

-- vim.api.nvim_set_keymap('c','wt',"wall<CR><cmd>ToggleTerm<cr>", {noremap = true, silent = true , desc = "Write and Toggle terminal" })
-- vim.api.nvim_set_keymap('c','wl',"wall<CR><cmd>lua require('resession').load()<cr>", {noremap = true, silent = true , desc = "Write and Load terminal" })

-- Keymap set. More like Lua than the above setup
vim.keymap.set('i',';fb',function() require("telescope.builtin").buffers() end , {noremap = true, silent = true , desc = "Redo Insert Mode" })
vim.keymap.set('n',';fb',function() require("telescope.builtin").buffers() end, {noremap = true, silent = true , desc = "Redo Insert Mode" })

vim.keymap.set('n',"<Leader>fs",function() require("resession").load() end,{noremap = true, desc = "Load last session" })
vim.keymap.set('n',"<Leader>fl",function() require("resession").load() end,{noremap = true, desc = "Load last session" })
vim.keymap.set('n',"<Leader>..",function() require("resession").load(vim.fn.getcwd(), { dir = "dirsession" }) end,{noremap = true, desc = "Load last session" })

vim.keymap.set({'n','i'},";fs",function() require("resession").load() end,{noremap = true, desc = "Load last session" })
vim.keymap.set({'n','i'},";fl",function() require("resession").load() end,{noremap = true, desc = "Load last session" })
local function callSession(opts)
  local short_name = opts.args
  local session_name = ""
  if (short_name == "pwsh") then
    session_name = "pwsh_settings"
  elseif(short_name == "nvim") then
    session_name = "nvim_dotfiles"
  elseif(short_name == "hw") then
    session_name = "Highway"
  elseif(short_name == "linux") then
    session_name = "linux_env"
  elseif(short_name == "obs") then
    session_name = "obsidian"
  end
  -- print(session_name)
  require("resession").load(session_name)
end
vim.api.nvim_create_user_command("Session", callSession, {nargs = "?"})
vim.api.nvim_set_keymap('c','sss',"Session", {noremap = true, silent = true , desc = "Open Session" })
vim.api.nvim_set_keymap('c','ssp',"Session pwsh", {noremap = true, silent = true , desc = "Load pwsh_settings session" })
-- local function newSession(opts)
--   local session_name = opts.args
--   -- print(session_name)
--   require("resession").save(session_name)
-- end
-- vim.api.nvim_create_user_command("NewSession", callSession, {nargs = "?"})
-- vim.api.nvim_set_keymap('c','news',"NewSession", {noremap = true, silent = true , desc = "Write and Load terminal" })

-- TODO: check if there is more todo, 
-- TODO: config ToDo comment keymap things to navigate between todos faster.

vim.keymap.set({'n','i'},";ft","<cmd>TodoTelescope<cr>",{noremap = true, desc = "find TODO FIXME BUG etc.." })
vim.keymap.set({'n','i'},";fn",function() require("telescope").extensions.notify.notify() end,{noremap = true, desc = "find notifications" })
vim.keymap.set({'n','i'},";fw",function() require("telescope.builtin").live_grep() end,{noremap = true, desc = "find notifications" })
