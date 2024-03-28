if vim.loader and vim.fn.has "nvim-0.9.1" == 1 then vim.loader.enable() end

for _, source in ipairs {
  "astronvim.bootstrap",
  "astronvim.options",
  "astronvim.lazy",
  "astronvim.autocmds",
  "astronvim.mappings",
} do
  local status_ok, fault = pcall(require, source)
  if not status_ok then vim.api.nvim_err_writeln("Failed to load " .. source .. "\n\n" .. fault) end
end

if astronvim.default_colorscheme then
  if not pcall(vim.cmd.colorscheme, astronvim.default_colorscheme) then
    require("astronvim.utils").notify(
      ("Error setting up colorscheme: `%s`"):format(astronvim.default_colorscheme),
      vim.log.levels.ERROR
    )
  end
end
-- Start selfmade changes.
-- Environment customized
if vim.loop.os_uname().sysname == "Windows_NT" then
  -- print("Windows_NT env config.")
  -- vim.o.shell = "pwsh.exe"
  vim.cmd([[set shell=pwsh
  set shellcmdflag=-command
  set shellquote=\"
  set shellxquote=]])
else
  -- print("Unix env config.")  
end
vim.cmd([[
command -bang Q quit<bang>
command -bang W write<bang>
command -bang WQ wq<bang>
command -bang Wq wq<bang>
]])
vim.cmd([[colorscheme sonokai]])
vim.cmd([[set guifont=Iosevka\ Nerd\ Font\ Mono:h12]])

vim.api.nvim_create_user_command("Cppath", function()
    local path = vim.fn.expand("%:p")
    vim.fn.setreg("+", path)
    vim.notify('Copied "' .. path .. '" to the clipboard!')
end, {})

vim.cmd([[
command -bang CPPA Cppath
command Cppa Cppath
cnoremap cppa Cppath
]])
-- kickstart.nvim





-- Nvim init.lua plugin.
require("astronvim.utils").conditional_func(astronvim.user_opts("polish", nil, false), true)

return {
    colorscheme = "sonokai",
    plugins = {
      {
        "sainnhe/sonokai",
        init = function() -- init function runs before the plugin is loaded
          vim.g.sonokai_style = "shusia"
        end,
    },
  },
}


