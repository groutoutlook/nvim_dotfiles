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
  require("resession").save(session_name)
end
vim.api.nvim_create_user_command("Savess", saveSession, { nargs = "?" })

return {
  "stevearc/resession.nvim",
  lazy = true,
  dependencies = {
    {
      "AstroNvim/astrocore",
      opts = function(_, opts)
        local maps = opts.mappings
        maps.n["<Leader>s"] = vim.tbl_get(opts, "_map_sections", "s")
        maps.n["<Leader>sl"] = { function() require("resession").load "Last Session" end, desc = "Load last session" }
        maps.n["<Leader>ss"] = { function() require("resession").save() end, desc = "Save this session" }
        maps.n["<Leader>sS"] = {
          function() require("resession").save(vim.fn.getcwd(), { dir = "dirsession" }) end,
          desc = "Save this dirsession",
        }
        maps.n["<Leader>st"] = { function() require("resession").save_tab() end, desc = "Save this tab's session" }
        maps.n["<Leader>sd"] = { function() require("resession").delete() end, desc = "Delete a session" }
        maps.n["<Leader>sD"] =
          { function() require("resession").delete(nil, { dir = "dirsession" }) end, desc = "Delete a dirsession" }
        maps.n["<Leader>sf"] = { function() require("resession").load() end, desc = "Load a session" }
        maps.n["<Leader>sF"] =
          { function() require("resession").load(nil, { dir = "dirsession" }) end, desc = "Load a dirsession" }
        maps.n["<Leader>s."] = {
          function() require("resession").load(vim.fn.getcwd(), { dir = "dirsession" }) end,
          desc = "Load current dirsession",
        }
        opts.autocmds.resession_auto_save = {
          {
            event = "VimLeavePre",
            desc = "Save session on close",
            callback = function()
              local buf_utils = require "astrocore.buffer"
              local autosave = buf_utils.sessions.autosave
              if autosave and buf_utils.is_valid_session() then
                local save = require("resession").save
                if autosave.last then save("Last Session", { notify = false }) end
                if autosave.cwd then save(vim.fn.getcwd(), { dir = "dirsession", notify = false }) end
              end
            end,
          },
        }
      end,
    },
  },
  opts = {
    buf_filter = function(bufnr) return require("astrocore.buffer").is_restorable(bufnr) end,
    tab_buf_filter = function(tabpage, bufnr) return vim.tbl_contains(vim.t[tabpage].bufs, bufnr) end,
    extensions = { astrocore = {} },
  },
}
