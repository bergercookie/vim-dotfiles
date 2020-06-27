map <buffer> <leader>rt :!rusty-tags vi <CR>
setlocal colorcolumn=100

nmap gd <Plug>(rust-def)
nmap gs <Plug>(rust-def-split)
nmap gx <Plug>(rust-def-vertical)
nmap K  <Plug>(rust-doc)

" You probably want to install clippy beforehand for better suggestions
let g:ale_rust_cargo_use_clippy = executable('cargo-clippy')
let g:ale_rust_cargo_check_all_targets = 1

let b:ale_linters = ['cargo']
let g:ale_fixers['rust'] = ['rustfmt']
