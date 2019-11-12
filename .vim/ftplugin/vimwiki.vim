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

    let l:header = '= ' . l:date_str . ' ='
    put!=l:header

    let l:home = '== ' . 'home | project:home due:' . l:date_str . ' =='
    put=l:home
    " Make it more generic, perhaps have the caller give you these strings
    let l:work = '== ' . 'work | project:' . g:work_str . ' due:' . l:date_str . ' =='
    put=l:work

    let l:rest = '== ' . 'rest |' . ' project: due:' . l:date_str . ' =='
    put=l:rest
endfunc

function! PopulateDiaryMonth(year, month)
    " Add vimwiki sections for every day of the given month

    " Get number of days for the current month
    " February
    if a:month == 2
        let l:end = 28
    " January, March, May, July, August, October, December.
    elseif index([1, 3, 5, 7, 8, 10, 12], a:month) != -1
        let l:end = 31
    " April, June, November
    elseif index([4, 6, 9, 11], a:month) != -1
        let l:end = 30
    else
        echoerr('Invalid month given: ' . a:month)
    endif

    " add sections
    let l:cnt = 1
    while l:cnt <= l:end
        if l:cnt < 10
            let l:day = '0' . l:cnt
        else
            let l:day = l:cnt
        endif

        call MakeDiarySections(a:year, a:month, l:day)
        :execute 'normal oj'
        let l:cnt += 1

    endwhile
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
