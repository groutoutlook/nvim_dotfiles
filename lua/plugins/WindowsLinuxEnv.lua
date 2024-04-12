-- Neovim env.
-- Vanilla mapping
if vim.loop.os_uname().sysname == "Windows_NT" then
  -- print("Windows_NT env config.")
  -- vim.o.shell = "pwsh.exe"
  vim.cmd([[set shell=pwsh
  set shellcmdflag=-command
  set shellquote=\"
  set shellxquote=]])
else

end





return {
  
}
