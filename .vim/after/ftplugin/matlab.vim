" Vim filetype plugin file
" Language:	matlab
" Maintainer:	Fabrice Guy <fabrice.guy at gmail dot com>
" Last Changed: 2009 Nov 23 - Automatic insertion of comment header when new
" comment inserted

if exists("b:did_ftplugin")
  finish
endif
let b:did_ftplugin = 1

let s:save_cpo = &cpo
set cpo-=C

setlocal fo+=croql
setlocal comments=:%>,:%

if exists("loaded_matchit")
  let s:conditionalEnd = '\(([^()]*\)\@!\<end\>\([^()]*)\)\@!'
  let b:match_words = '\<classdef\>\|\<methods\>\|\<events\>\|\<properties\>\|\<if\>\|\<while\>\|\<for\>\|\<switch\>\|\<try\>\|\<function\>:' . s:conditionalEnd
endif

setlocal suffixesadd=.m
setlocal suffixes+=.asv
" Change the :browse e filter to primarily show M-files
if has("gui_win32") && !exists("b:browsefilter")
  let  b:browsefilter="M-files (*.m)\t*.m\n" .
	\ "All files (*.*)\t*.*\n"
endif

let b:undo_ftplugin = "setlocal suffixesadd< suffixes< "
      \ . "| unlet! b:browsefilter"
      \ . "| unlet! b:match_words"

let &cpo = s:save_cpo


" Wed Jun 24 18:19:49 EEST 2015, nickkouk
nmap <F12> v:!echo '\%' $(LC_ALL=C date)', nickkouk'<CR>
imap <F12> <ESC>v:!echo '\%' $(LC_ALL=C date)', nickkouk'<CR>


" abbreviations for matlab editing
ab bcomment %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%<backspace> <backspace><CR>
ab section %======================================================<backspace> <backspace><CR>
ab subsection %+++++++++++++++++++++++++++++++++++++++++++++++++++++<<backspace> <backspace><CR>
ab subsubsection %------------------------------------------------------<backspace> <backspace><CR>
ab paragraph %xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx<backspace> <backspace><CR>
ab subparagraph %//////////////////////////////////////////////////////<backspace> <backspace><CR>

