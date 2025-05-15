-- INFO: This will run last in the setup process and is a good place to configure
-- things like custom filetypes. This just pure lua so anything that doesn't
-- fit in the normal config locations above can go here

-- vim.filetype.add {
--   extension = {
--     foo = "fooscript",
--   },
--   filename = {
--     ["Foofile"] = "fooscript",
--   },
--   pattern = {
--     ["~/%.config/foo/.*"] = "fooscript",
--   },
-- }
-- filetype function.
vim.filetype.add {
  extension = {
    tmp = "markdown",
    ini = "markdown",
    jrnl = "markdown",
    zshrc = "zsh",
    hlsl = "cpp",
    vert = "glsl",
    frag = "glsl",
    geom = "glsl",
    -- glsl = "cpp",
  },
}
-- INFO: shell info.
if vim.loop.os_uname().sysname == "Windows_NT" then
  vim.o.shell = "pwsh"
  vim.o.shellcmdflag = [[-Command [Console]::InputEncoding=[Console]::OutputEncoding=[System.Text.UTF8Encoding]::new();`
  $PSDefaultParameterValues['Out-File:Encoding']='utf8';`
  ]]
  -- Remove-Alias -Force -ErrorAction SilentlyContinue tee;
  vim.o.shellredir = "2>&1 | %%{ '$_' } | Out-File %s; exit $LastExitCode"
  vim.o.shellpipe = "2>&1 | %%{ '$_' } | tee %s; exit $LastExitCode"
  vim.o.shellquote = ""
  vim.o.shellxquote = ""
else
  vim.o.shell = 'nu'
  vim.o.shellcmdflag = '-c'
  vim.o.shellquote = ""
  vim.o.shellxquote = ""
end

return {}
