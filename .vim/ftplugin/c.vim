setlocal suffixesadd+=.c,.h
map <buffer> <leader>rt :!ctags -R --fields=+liaS --extra=+q --tag-relative . <CR>
