setlocal suffixesadd+=.h,.hpp,.hxx,.c,.cc,.cpp,.cxx
setlocal path+=/usr/include/c++/
setlocal commentstring=//\ %s
set matchpairs+=<:>

nmap <buffer> <Leader>C :ClangFormatAutoToggle<CR>
nmap <buffer> <leader>rt :Dispatch ctags -R --c++-kinds=+p --fields=+liaS --extra=+q --tag-relative . <CR>
nmap <silent><buffer> K <Esc>:Cppman <cword><CR>
