map <buffer> <leader>rt :!rusty-tags vi <CR>
setlocal colorcolumn=100

nmap gd <Plug>(rust-def)
nmap gs <Plug>(rust-def-split)
nmap gx <Plug>(rust-def-vertical)
nmap K  <Plug>(rust-doc)

" You probably want to install clippy beforehand for better suggestions
