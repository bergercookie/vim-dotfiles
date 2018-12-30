" Make sure that you have also set up TaskWiki
setlocal textwidth=0
ActivateBritishSpelling

" Toggle Filetype - two different mappings {{{
nmap <buffer> <leader>cf :set filetype=<CR>
nmap <buffer> <leader>cF :set filetype=vimwiki<CR>
cmap <buffer> twa :TaskWikiAnnotate<CR>
cmap <buffer> vwg :VimwikiGoto
cmap <buffer> vwt :VimwikiSearchTags

let b:autopairs_loaded=1
" }}}

