-- Neovim env.
-- Vanilla mapping
if vim.loop.os_uname().sysname == "Windows_NT" then
  -- print("Windows_NT env config.")
  -- vim.o.shell = "pwsh.exe"
  vim.cmd [[set shell=pwsh
  set shellcmdflag=-command
  set shellquote=\"
  set shellxquote=]]
  require("notify").setup {
    timeout = 1500,
    -- stages = "static",
  }
  return {}
else
  return {
    -- TODO: I dont think of any proper way to make neovim detect termux host and separate them between Desktop host which is more capable, and the termux host which is fragile.
    -- TODO: So the method for now, If I have any intention using this setup outside of my phones and my Windows Machine, is passing a variable when starting neovim then.
    -- TODO: Or a special fork/file which determine OS, such as the way zsh and neofetch can detect our OS.
    require("notify").setup {
      timeout = 200,
      -- stages = "static",
    },
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
