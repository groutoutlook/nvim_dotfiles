-- if true then return {} end -- WARN: REMOVE THIS LINE TO ACTIVATE THIS FILE

-- AstroCommunity: import any community modules here
-- We import this file in `lazy_setup.lua` before the `plugins/` folder.
-- This guarantees that the specs are processed before any user plugins.

---@type LazySpec

if vim.loop.os_uname().sysname == "Windows_NT" then
  return {
    "AstroNvim/astrocommunity",
    -- Desktop.
    { import = "astrocommunity.pack.lua" },
    { import = "astrocommunity.pack.cpp" },
    { import = "astrocommunity.pack.typst" },
    -- { import = "astrocommunity.pack.markdown" },
    { import = "astrocommunity.pack.rainbow-delimiter-indent-blankline" },
    -- { import = "astrocommunity.utility.noice-nvim" },
    { import = "astrocommunity.code-runner.overseer-nvim" },
    { import = "astrocommunity.code-runner.conjure" },
    -- Neovide extra settings.
    { import = "astrocommunity.recipes.neovide" },
    { import = "astrocommunity.motion.leap-nvim" },
    { import = "astrocommunity.motion.flit-nvim" },
    -- { import = "astrocommunity.motion.grapple-nvim" },
    { import = "astrocommunity.motion.mini-move" },
    { import = "astrocommunity.motion.nvim-surround" },
    { import = "astrocommunity.file-explorer.mini-files" },
    -- { import = "astrocommunity.file-explorer.telescope-file-browser-nvim" },
    -- { import = "astrocommunity.editing-support.yanky-nvim" },
    { import = "astrocommunity.editing-support.dial-nvim" },
    { import = "astrocommunity.editing-support.ultimate-autopair-nvim" },
    { import = "astrocommunity.search.nvim-hlslens" },
    { import = "astrocommunity.search.nvim-spectre" },
  }
else
  return {
    "AstroNvim/astrocommunity",
    -- { import = "astrocommunity.pack.lua" },
    -- { import = "astrocommunity.pack.cpp" },
    -- { import = "astrocommunity.pack.markdown" },
    { import = "astrocommunity.pack.rainbow-delimiter-indent-blankline" },
    { import = "astrocommunity.code-runner.overseer-nvim" },
    { import = "astrocommunity.code-runner.conjure" },
    { import = "astrocommunity.motion.leap-nvim" },
    { import = "astrocommunity.motion.flit-nvim" },
    -- { import = "astrocommunity.motion.grapple-nvim" },
    { import = "astrocommunity.motion.mini-move" },
    { import = "astrocommunity.motion.nvim-surround" },
    -- { import = "astrocommunity.snippet.nvim-snippets" },
    { import = "astrocommunity.file-explorer.mini-files" },
    -- { import = "astrocommunity.editing-support.yanky-nvim" },
    { import = "astrocommunity.editing-support.dial-nvim" },
    { import = "astrocommunity.editing-support.ultimate-autopair-nvim" },
    { import = "astrocommunity.search.nvim-hlslens" },
  }
end
