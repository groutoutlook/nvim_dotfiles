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

return {
}
