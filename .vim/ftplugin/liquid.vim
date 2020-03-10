function! WrapInCodeBlock()
    normal! O{% highlight bash %}
    :exe "normal "
    normal! jo{% endhighlight %}
    :exe "normal "
endfunc
command! WrapInCodeBlock :call WrapInCodeBlock()<CR>

function! ConvertVimwikiLinkToMarkdown()
  let old=&tw
  :exe "normal ds[f|xdT[$a("
  let &tw=old
endfunc
command! ConvertVimwikiLinkToMarkdown :call ConvertVimwikiLinkToMarkdown()

function! ConvertVimwikiHeaderToMarkdown()
  :exe "normal 0viwr#Akb"
endfunc
command! ConvertVimwikiHeaderToMarkdown :call ConvertVimwikiHeaderToMarkdown()

setlocal spell
setlocal spelllang=en,el

setlocal filetype=liquid
