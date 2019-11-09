" Make sure that you have also set up TaskWiki
setlocal textwidth=80
setlocal spell
setlocal spelllang=en,el

" Toggle Filetype - two different mappings {{{
nmap <buffer> <leader>cf :set filetype=<CR>
nmap <buffer> <leader>cF :set filetype=vimwiki<CR>
silent! unmap <buffer> =
" }}}

let b:autopairs_loaded=1

" MakeDiarySections function - use taskwiki viewports {{{
function! MakeDiarySections()
    let l:date_str = strftime('%Y-%m-%d')
    let l:header = "= " . l:date_str . " ="
    put!=l:header

    let l:home = "== " . "home | project:home due:" . l:date_str . " =="
    put=l:home
    " Make it more generic, perhaps have the caller give you these strings
    let l:work = "== " . "work | project:" . g:work_str . " due:" . l:date_str . " =="
    put=l:work

    let l:rest = "== " . "rest |" . " project: due:" . l:date_str . " =="
    put=l:rest
endfunc

function! PopulateWeeklyDone()
    let l:date_str = strftime('%Y-%m-%d')
    let l:header = "= Work until " . l:date_str . " | project:" . g:work_str .
                \ " end.after:today-1wk status:completed " .  "="
    put!=l:header

    let l:refined_str = "Refined List"
    put!=l:refined_str
endfunc

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

function! AddHeaderLvl()
    :exe "normal 0i=A="
endfunc
nmap <buffer> <leader>= :call AddHeaderLvl()<CR>
