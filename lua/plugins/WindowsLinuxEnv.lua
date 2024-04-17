-- Neovim env.
-- Vanilla mapping
if vim.loop.os_uname().sysname == "Windows_NT" then
  -- print("Windows_NT env config.")
  -- vim.o.shell = "pwsh.exe"
  vim.cmd [[set shell=pwsh
  set shellcmdflag=-command
  set shellquote=\"
  set shellxquote=]]

  return {}
else
  return {
    -- {
    --   "williamboman/mason-lspconfig.nvim",
    --   -- overrides `require("mason-lspconfig").setup(...)`
    --   opts = function(_, opts)
    --     -- add more things to the ensure_installed table protecting against community packs modifying it
    --     opts.ensure_installed = require("astrocore").list_insert_unique(opts.ensure_installed, {
    --       -- "lua_ls",
    --       -- add more arguments for adding more language servers
    --     })
    --   end,
    -- },
  }
end
