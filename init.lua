local lazypath = vim.env.LAZY or vim.fn.stdpath "data" .. "/lazy/lazy.nvim"
if not (vim.env.LAZY or (vim.uv or vim.loop).fs_stat(lazypath)) then
  -- stylua: ignore
  vim.fn.system({ "git", "clone", "--filter=blob:none", "https://github.com/folke/lazy.nvim.git", "--branch=stable",
    lazypath })
end
vim.opt.rtp:prepend(lazypath)

if not pcall(require, "lazy") then
  vim.api.nvim_echo(
  { { ("Unable to load lazy from: %s\n"):format(lazypath), "ErrorMsg" }, { "Press any key to exit...", "MoreMsg" } },
    true, {})
  vim.fn.getchar()
  vim.cmd.quit()
end
require "lazy_setup"
require "polish"

-- turn off tabline.
-- vim.opt.showtabline = 0
vim.cmd [[
command! -bang Q quit<bang>
command! -bang W write<bang>
command! -bang WQ wq<bang>
command! -bang Wq wq<bang>
]]
if vim.fn.has "gui_running" == 1 then
  vim.cmd.colorscheme "cyberdream"
  vim.o.guifont = "Iosevka Nerd Font Propo:h20" -- text below applies for VimScript
  vim.g.transparency = 0.7
  local alpha = function() return string.format("%x", math.floor(255 * vim.g.transparency or 0.8)) end
  vim.g.neovide_transparency = 0.8
  vim.g.neovide_background_color = "#0f1117" .. alpha()
  vim.g.neovide_cursor_vfx_mode = "railgun"
  vim.g.neovide_floating_shadow = false
  vim.g.neovide_profiler = false
else
  vim.cmd.colorscheme "cyberdream"
end
