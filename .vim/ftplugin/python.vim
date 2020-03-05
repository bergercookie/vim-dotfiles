" set foldmethod=indent
set colorcolumn=95
set tw=95 " 95 is a soft limit

" Forbidden linters:
" - pylint
let b:ale_linters = ['flake8', 'autopep8', 'mypy', 'yapf', 'vulture']
let g:ale_fixers['python'] = ['black', 'isort']
let g:ale_python_black_options = "-q --line-length " . &tw . " -t py36 -"

let test#python#runner = 'pyunit'
let test#python#pyunit#executable = 'python3 -m unittest'

func! s:SetBreakpoint()
    cal append('.', repeat(' ', strlen(matchstr(getline('.'), '^\s*'))) . 'import pdb; pdb.set_trace()')
endf
map <buffer> <leader>dp :call <SID>SetBreakpoint()<CR>
