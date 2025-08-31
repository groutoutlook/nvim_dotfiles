-- My course remap. Want to move it out of init.lua.
vim.keymap.set(
  { "n", "i" },
  ";fs",
  function() require("resession").load() end,
  { noremap = true, desc = "Select session" }
)
local function saveSession(opts)
  local session_name = opts.args
  if session_name == "" then session_name = require("resession").get_current() end
  require("resession").save(session_name)
end
vim.api.nvim_create_user_command("Savess", saveSession, { nargs = "?" })

return {}
