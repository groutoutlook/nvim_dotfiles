-- This file simply bootstraps the installation of Lazy.nvim and then calls other files for execution
-- This file doesn't necessarily need to be touched, BE CAUTIOUS editing this file and proceed at your own risk.
local lazypath = vim.env.LAZY or vim.fn.stdpath "data" .. "/lazy/lazy.nvim"
if not (vim.env.LAZY or (vim.uv or vim.loop).fs_stat(lazypath)) then
  -- stylua: ignore
  vim.fn.system({ "git", "clone", "--filter=blob:none", "https://github.com/folke/lazy.nvim.git", "--branch=stable", lazypath })
end
vim.opt.rtp:prepend(lazypath)

-- validate that lazy is available
if not pcall(require, "lazy") then
  -- stylua: ignore
  vim.api.nvim_echo({ { ("Unable to load lazy from: %s\n"):format(lazypath), "ErrorMsg" }, { "Press any key to exit...", "MoreMsg" } }, true, {})
  vim.fn.getchar()
  vim.cmd.quit()
end
require "lazy_setup"
require "polish"
-- turn off tabline.
vim.opt.showtabline = 0
vim.api.nvim_create_autocmd({ "BufReadPre", "BufNewFile" }, {
  pattern = { "*.c", "*.cpp", "*.h", "*.hpp", "*.hlsl", "*.glsl" },
  callback = function()
    vim.opt.laststatus = 0 -- require("astrocore.toggles").statusline()
    -- vim.notify "cpp files entering..."
    require("astrocore").config.features.diagnostics_mode = 1
    require("astrolsp").config.formatting = {
      format_on_save = {
        enabled = false,
        -- ignore_filetypes = { "cpp", "c" },
      },
      disabled = {
        "clangd",
      },
    }
  end,
})

vim.api.nvim_create_autocmd({ "BufNewFile", "BufReadPre" }, {
  -- group = vim.api.nvim_create_augroup("PrivateJrnl", {}),
  pattern = { "*.jrnl" },
  callback = function()
    vim.o.shada = ""
    vim.o.swapfile = false
    vim.o.undofile = false
    vim.o.backup = false
    vim.o.writebackup = false
    vim.o.shelltemp = false
    vim.o.history = 0
    vim.o.modeline = false
    vim.o.secure = true
  end,
})

vim.cmd [[
command! -bang Q quit<bang>
command! -bang W write<bang>
command! -bang WQ wq<bang>
command! -bang Wq wq<bang>
set conceallevel=2
nnoremap <expr> <C-d> (winheight(0) / 3) . '<C-d>'
nnoremap <expr> <C-u> (winheight(0) / 3) . '<C-u>'
]]
if vim.fn.has "gui_running" == 1 then
  vim.cmd.colorscheme "slate"
  vim.o.guifont = "Iosevka Nerd Font Propo:h13" -- text below applies for VimScript

  local alpha = function() return string.format("%x", math.floor(255 * vim.g.transparency or 0.8)) end

  vim.g.neovide_transparency = 0.5
  vim.g.transparency = 0.7
  vim.g.neovide_background_color = "#0f1117" .. alpha()
  vim.g.neovide_cursor_vfx_mode = "railgun"
end
--Basic Lua
