-- set termguicolors is hear just because of the notify setup settings.
-- vim.cmd["set"] "termguicolors"

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
  return {}
else
  return {}
end
