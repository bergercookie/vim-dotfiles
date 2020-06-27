setlocal tabstop=2
setlocal shiftwidth=2
setlocal preserveindent
setlocal copyindent
setlocal softtabstop=2
setlocal autoindent
setlocal expandtab
setlocal textwidth=120

let b:ale_linters = ['yamllint']
let g:ale_fixers['yaml'] = ['prettier']
