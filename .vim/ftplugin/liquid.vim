function! WrapInCodeBlock()
    normal! O{% highlight bash %}
    :exe "normal "
    normal! jo{% endhighlight %}
    :exe "normal "
endfunc
nmap <buffer> <leader>wb :call WrapInCodeBlock()<CR>

setlocal spell
setlocal spelllang=en,el

setlocal filetype=liquid
