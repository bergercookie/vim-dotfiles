setlocal suffixesadd+=.h,.hpp,.hxx,.c,.cc,.cpp,.cxx
setlocal path+=/usr/include/c++/
setlocal commentstring=//\ %s

nmap <buffer> <Leader>C :ClangFormatAutoToggle<CR>
nmap <buffer> <leader>rt :!ctags -R --c++-kinds=+p --fields=+liaS --extra=+q --tag-relative . <CR>
nmap <silent><buffer> K <Esc>:Cppman <cword><CR>

let b:ale_linters = [
            \ 'cppcheck', 'clang', 'clangd', 'gcc',
            \ 'clang-check', 'clang-tidy', 'clang-format',
            \ 'flawfinder', 'ccls']
