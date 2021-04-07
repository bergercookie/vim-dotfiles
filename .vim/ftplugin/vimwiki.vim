" Make sure that you have also set up TaskWiki
" And also make sure that the `g:work_str` string is setup in your vimrc
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
function! MakeDiarySections(...)
    " argument checking
    if len(a:000) == 0
        let l:date_str = strftime('%Y-%m-%d')
    elseif len(a:000) == 3
        " year-month-day
        let l:date_str = a:1 . '-' . a:2 . '-' . a:3
    else
        echoerr('Wrong number of arguments')
        return
    endif

    let l:headers = "= " . l:date_str . " =\n" .
                  \ "== Personal items |" . " project.not:" . g:work_str . " due:" . l:date_str . " ==\n" .
                  \ "== Work items | project:" . g:work_str . " due:" . l:date_str . " =="
    put=l:headers
endfunc
" }}}

" Populate all the tasks you have done and those that are still pending from last week {{{
function! PopulateWeeklyDone()
    let l:date_str = strftime('%Y-%m-%d')
    let l:headers = "=Week ending on " . strftime("%Y-%m-%d") . "=\n" .
                  \ "== Work items since " . l:date_str . " | project:" . g:work_str .
                  \ " end.after:" . l:date_str . "-1wk status:completed ==\n" .
                  \ "== Undone items since " . l:date_str . " | project:" . g:work_str .
                  \ " end.after:" . l:date_str . "-1wk due.before:" . l:date_str . "+1d status:pending ==\n" .
                  \ "== Personal items since " . l:date_str . " | project.not:" . g:work_str .
                  \ " due.after:" . l:date_str . "-1wk due.before:" . l:date_str . "+1d status:completed ==\n" .
                  \ "== Undone items since " . l:date_str . " | project.not:" . g:work_str .
                  \ " due.after:" . l:date_str . "-1wk due.before:" . l:date_str . "+1d status:pending ==\n"
    put!=l:headers
endfunc
"}}}

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
