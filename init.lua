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



vim.cmd([[colorscheme sonokai]])
vim.cmd([[command -bang Q quit<bang>]])

vim.cmd([[command -bang W write<bang>]])
vim.cmd([[set guifont=Iosevka\ Nerd\ Font\ Mono:h12]])

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
