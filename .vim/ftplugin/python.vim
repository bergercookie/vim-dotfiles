" set foldmethod=indent
set colorcolumn=95
set tw=95 " 95 is a soft limit

let test#python#runner = 'pyunit'
let test#python#pyunit#executable = 'python3 -m unittest'

func! s:SetBreakpoint()
    cal append('.', repeat(' ', strlen(matchstr(getline('.'), '^\s*'))) . 'import ipdb; ipdb.set_trace()')
endf
map <buffer> <leader>dp :call <SID>SetBreakpoint()<CR>
