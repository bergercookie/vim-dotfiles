" Make sure that you have also set up TaskWiki
setlocal textwidth=80
" ActivateBritishSpelling
set spell
set spelllang=en,el

" Toggle Filetype - two different mappings {{{
nmap <buffer> <leader>cf :set filetype=<CR>
nmap <buffer> <leader>cF :set filetype=vimwiki<CR>
silent! unmap <buffer> =
" }}}

let b:autopairs_loaded=1

" Add links to vimwiki words {{{
" Easily add links. URL should be copied in the clipboard and cursor
" should be on top of the word.
"
" Plugins used: vim-surround
function! AddVimWikiLink()
    let v=&wrap
    set nowrap
    :exe "normal ysiw]ysa]]lpa|"
    let &wrap=v
endfunc
function! AddVimWikiLink2()
    let v=&wrap
    set nowrap
    :exe "normal ysiW]ysa]]lpa|"
    let &wrap=v
endfunc
nmap <buffer> <leader>al :call AddVimWikiLink()<CR>
nmap <buffer> <leader>aL :call AddVimWikiLink2()<CR>
"}}}

function! WrapInCodeBlock()
    normal! O{% highlight bash %}
    :exe "normal "
    normal! jo{% endhighlight %}
    :exe "normal "
endfunc
nmap <buffer> <leader>wb :call WrapInCodeBlock()<CR>
