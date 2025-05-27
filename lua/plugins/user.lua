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
vim.o.shell = 'nu'
vim.o.shellcmdflag = '-c'
vim.o.shellquote = ""
vim.o.shellxquote = ""
-- start the playground
-- vim.keymap.set("n", "<leader>jq", vim.cmd.JqPlayground)
-- -- when in the query window, run the jq query
-- vim.keymap.set("n", "R", "<Plug>(JqPlaygroundRunQuery)")

local group = vim.api.nvim_create_augroup("CsvViewEvents", {})
vim.api.nvim_create_autocmd("User", {
  pattern = "CsvViewAttach",
  group = group,
  callback = function(args)
    local bufnr = tonumber(args.data)
    print("CsvView is attached", bufnr)
  end,
})

-- Define keymaps for csvview functions
local opts = {
  keymaps = {
    -- Toggle CSV view
    {
      mode = "n",
      key = "<c-w><c-e>", -- <leader>ct for "CSV toggle"
      action = "<cmd>lua require('csvview').toggle()<CR>",
      desc = "Toggle CSV view",
    },
  },
}

-- Register keymaps
for _, keymap in ipairs(opts.keymaps) do
  vim.keymap.set(keymap.mode, keymap.key, keymap.action, { desc = keymap.desc, noremap = true, silent = true })
end

-- Configure leap.nvim
require('leap').setup({
  -- Optional: Add any specific configurations if needed
})

-- INFO: Map <Enter> to leap. This is same behaviour as helix. 
vim.keymap.set({ 'n', 'x', 'o' }, '<CR>', '<Plug>(leap)', { desc = 'Leap forward with Enter' })
vim.keymap.set({ 'i'}, ';<CR>', '<Esc><Plug>(leap)', { desc = 'Leap forward with Enter' })

return { }
