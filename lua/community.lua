-- if true then return {} end -- WARN: REMOVE THIS LINE TO ACTIVATE THIS FILE

-- AstroCommunity: import any community modules here
-- We import this file in `lazy_setup.lua` before the `plugins/` folder.
-- This guarantees that the specs are processed before any user plugins.

---@type LazySpec

if vim.loop.os_uname().sysname == "Windows_NT" then
  return {
    "AstroNvim/astrocommunity",
    { import = "astrocommunity.pack.lua" },
    { import = "astrocommunity.pack.cpp" },
    { import = "astrocommunity.pack.markdown" },
    { import = "astrocommunity.utility.noice-nvim" },
    { import = "astrocommunity.code-runner.overseer-nvim" },
    -- Minimap for code, only available on desktop. Termux cant run.
    -- { import = "astrocommunity.split-and-window.minimap-vim" },
    { import = "astrocommunity.split-and-window.mini-map" },
    -- Only needed when using terminal. Using Neovide as GUI has animation built-in
    -- { import = "astrocommunity.scrolling.mini-animate" },
    -- Neovide extra settings.
    { import = "astrocommunity.recipes.neovide" },
    -- import/override with your plugins folder
  }
else
  return {
    "AstroNvim/astrocommunity",
    -- { import = "astrocommunity.pack.lua" },
    -- { import = "astrocommunity.pack.cpp" },
    { import = "astrocommunity.pack.markdown" },
    { import = "astrocommunity.utility.noice-nvim" },
    -- { import = "astrocommunity.code-runner.overseer-nvim" },
    -- Yeah install this on termux or linux with little to no ability to run animation GUI.
    -- { import = "astrocommunity.scrolling.mini-animate" },
    { import = "astrocommunity.split-and-window.mini-map" },
    -- import/override with your plugins folder
  }
end
