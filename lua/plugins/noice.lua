vim.keymap.set("n", "<leader>nl", function() require("noice").cmd "last" end)

vim.keymap.set("n", "<leader>nh", function() require("noice").cmd "history" end)

vim.keymap.set(
  "c",
  "<S-Enter>",
  function() require("noice").redirect(vim.fn.getcmdline()) end,
  { desc = "Redirect Cmdline" }
)

vim.keymap.set({ "n", "i", "s" }, "<c-f>", function()
  if not require("noice.lsp").scroll(4) then return "<c-f>" end
end, { silent = true, expr = true })

vim.keymap.set({ "n", "i", "s" }, "<c-b>", function()
  if not require("noice.lsp").scroll(-4) then return "<c-b>" end
end, { silent = true, expr = true })

return {}
