-- Neovim env.
-- Vanilla mapping

-- set termguicolors is hear just because of the notify setup settings.
vim.cmd["set"] "termguicolors"

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

  -- require("notify").setup {
  --   timeout = 1000,
  --   -- stages = "static",
  -- }
  return {}
else
  return {
    -- TODO: I dont think of any proper way to make neovim detect termux host and separate them between Desktop host which is more capable, and the termux host which is fragile.
    -- So the method for now, If I have any intention using this setup outside of my phones and my Windows Machine, is passing a variable when starting neovim then.
    -- Or a special fork/file which determine OS, such as the way zsh and neofetch can detect our OS.
    require("notify").setup {
      timeout = 150,
      stages = "static",
    },
  }
end
