-- HACK: Emacs navigation., based on `emacsinsert.nvim`
local emacsinsert = require "emacsinsert"
-- vim.keymap.set("!", "<C-k>", emacsinsert.kill_line)
vim.keymap.set("!", "<C-u>", emacsinsert.backward_kill_line)
vim.keymap.set("!", "<M-d>", emacsinsert.kill_word)
vim.keymap.set("!", "<M-w>", emacsinsert.kill_word)
vim.keymap.set("!", "<M-BS>", emacsinsert.backward_kill_word)
-- vim.keymap.set("!", "<C-w>", emacsinsert.unix_word_rubout)
vim.keymap.set("!", "<C-d>", "<Delete>") -- delete-char
vim.keymap.set("!", "<c-h>", "<BS>") -- backward-delete-char
vim.keymap.set("!", "<C-a>", emacsinsert.beginning_of_line)
vim.keymap.set("!", "<C-e>", emacsinsert.end_of_line)
-- vim.keymap.set("!", "<M-f>", emacsinsert.forward_word)
-- vim.keymap.set("!", "<M-b>", emacsinsert.backward_word)
-- vim.keymap.set("!", "<C-f>", "<Right>") -- forward-char
-- vim.keymap.set("!", "<C-b>", "<Left>") -- backward-char
vim.keymap.set("!", "<C-Up>", emacsinsert.backward_paragraph)
vim.keymap.set("!", "<C-Down>", emacsinsert.forward_paragraph)
-- vim.keymap.set("!", "<C-n>", "<Down>") -- next-line
-- vim.keymap.set("!", "<C-p>", "<Up>") -- previous-line

-- INFO: shell info.
if vim.loop.os_uname().sysname == "Windows_NT" then
  vim.o.shell = "pwsh"
  vim.o.shellcmdflag = [[-Command [Console]::InputEncoding=[Console]::OutputEncoding=[System.Text.UTF8Encoding]::new();`
  $PSDefaultParameterValues['Out-File:Encoding']='utf8';`
  ]]
  -- Remove-Alias -Force -ErrorAction SilentlyContinue tee;
  vim.o.shellredir = "2>&1 | %%{ '$_' } | Out-File %s; exit $LastExitCode"
  vim.o.shellpipe = "2>&1 | %%{ '$_' } | tee %s; exit $LastExitCode"
  vim.o.shellquote = ""
  vim.o.shellxquote = ""
else
  vim.o.shell = 'nu'
  vim.o.shellcmdflag = '-c'
  vim.o.shellquote = ""
  vim.o.shellxquote = ""
end

return { }
