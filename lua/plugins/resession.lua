-- My course remap. Want to move it out of init.lua.
vim.keymap.set(
  { "n", "i" },
  ";fs",
  "<cmd>wall<CR><cmd>lua require('resession').load()<cr>",
  { noremap = true, silent = true, desc = "Write and Save session" }
)

vim.keymap.set(
  { "n", "i" },
  ";wl",
  "<cmd>wall<CR><cmd>lua require('resession').load()<cr>",
  { noremap = true, silent = true, desc = "Write and Load session" }
)

vim.keymap.set(
  "n",
  "<Leader>fs",
  function() require("resession").load() end,
  { noremap = true, desc = "Select session" }
)

vim.keymap.set(
  "n",
  "<Leader>..",
  function() require("resession").load(vim.fn.getcwd(), { dir = "dirsession" }) end,
  { noremap = true, desc = "Load dirsession" }
)

vim.keymap.set(
  { "n", "i" },
  ";fs",
  function() require("resession").load() end,
  { noremap = true, desc = "Select session" }
)

vim.keymap.set(
  { "n", "i" },
  ";sl",
  function() require("resession").load "Last Session" end,
  { noremap = true, desc = "Load last session" }
)

vim.keymap.set(
  { "n", "i" },
  ";..",
  function() require("resession").load(vim.fn.getcwd(), { dir = "dirsession" }) end,
  { noremap = true, desc = "Load current dir session" }
)

vim.keymap.set(
  { "n", "i" },
  ";s.",
  function() require("resession").load(vim.fn.getcwd(), { dir = "dirsession" }) end,
  { noremap = true, desc = "Load current dir session" }
)

local function saveSession(opts)
  local session_name = opts.args
  if session_name == "" then session_name = require("resession").get_current() end
  require("resession").save(session_name)
end
vim.api.nvim_create_user_command("Savess", saveSession, { nargs = "?" })

return {}
