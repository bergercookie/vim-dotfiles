" prevent multiple loading
if exists("b:did_my_ftplugin") | finish | endif
let b:did_my_ftplugin = 1

setlocal formatoptions+=t
setlocal formatoptions-=l

setlocal expandtab
setlocal foldlevelstart=999
setlocal foldminlines=0
setlocal shiftwidth=2
setlocal smartindent
setlocal softtabstop=2
setlocal tabstop=2

setlocal foldmethod=indent
set syntax=xml
