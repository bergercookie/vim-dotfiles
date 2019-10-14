setlocal tabstop=4
setlocal shiftwidth=2
setlocal nopreserveindent
setlocal nocopyindent
setlocal softtabstop=4
setlocal noautoindent
setlocal expandtab
setlocal textwidth=80

set spell
set spelllang=en,el

function! WrapInCodeBlock()
    normal! O
    {% highlight bash %}
    :exe "normal "
    normal! jo
    {% endhighlight %}
    :exe "normal "
endfunc
nmap <buffer> <leader>wb :call WrapInCodeBlock()<CR>

function! ConvertVimwikiLinkToMarkdown()
  let old=&tw
  :exe "normal ds[f|xdT[$a("
  let &tw=old
endfunc
nmap <buffer> <leader>cl :call ConvertVimwikiLinkToMarkdown()<CR>
