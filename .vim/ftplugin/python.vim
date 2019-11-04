set foldmethod=indent
set colorcolumn=95
set tw=95 " 95 is a soft limit

" Forbidden linters:
" - pylint
let b:ale_linters = ['flake8', 'autopep8', 'mypy', 'yapf', 'vulture']
let test#python#runner = 'pyunit'
let test#python#pyunit#executable = 'python3 -m unittest'

" https://gist.github.com/berinhard/523420/89ce9864ce60b9053b31c8a26a20ae0355892f3b
let b:python_pdb_s='import pdb; pdb.set_trace()'
func! s:SetBreakpoint()
    cal append('.', repeat(' ', strlen(matchstr(getline('.'), '^\s*'))) . 'import pdb; pdb.set_trace()')
endf
map <buffer> <leader>dp :call <SID>SetBreakpoint()<CR>
