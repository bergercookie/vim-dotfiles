let b:python_pdb_s='import pdb; pdb.set_trace()'
map <buffer> <leader>dp :put=b:python_pdb_s<CR>

let b:ale_linters = ['flake8', 'pylint']
