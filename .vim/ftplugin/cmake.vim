setlocal tabstop=4
setlocal shiftwidth=4
setlocal preserveindent
setlocal copyindent
setlocal softtabstop=4
setlocal autoindent
setlocal expandtab
setlocal commentstring=#\ %s

let b:ale_linters = ['cmakelint']
let g:ale_fixers["cmake"] = ["cmakeformat", 'remove_trailing_lines', 'trim_whitespace']
