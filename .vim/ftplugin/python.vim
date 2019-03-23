let b:python_pdb_s='import pdb; pdb.set_trace()'

" Forbidden linters:
" - pylint
let b:ale_linters = ['flake8', 'autopep8', 'mypy', 'yapf', 'vulture']

" https://gist.github.com/berinhard/523420/89ce9864ce60b9053b31c8a26a20ae0355892f3b
func! s:SetBreakpoint()
    cal append('.', repeat(' ', strlen(matchstr(getline('.'), '^\s*'))) . 'import ipdb; ipdb.set_trace()')
endf
map <buffer> <leader>dp :call <SID>SetBreakpoint()<CR>

