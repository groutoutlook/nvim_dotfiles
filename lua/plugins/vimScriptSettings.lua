-- Move basic vim mapping to here since I break those keymap beneath them frequently.
vim.cmd([[
set guifont=Iosevka\ Nerd\ Font\ Mono:h12
colorscheme torte
command -bang Q quit<bang>
command -bang W write<bang>
command -bang WQ wq<bang>
command -bang Wq wq<bang>
set conceallevel=2
]])


return{
  
}
