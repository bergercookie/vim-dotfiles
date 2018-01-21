""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Fri Dec 29 12:51:00 EET 2017 - Nikos Koukis
" This is the main vimrc file used both in my linux and mac machines.
"  - Formmatting
"  - Syntax
"  - Automation procedures
"  - Loading plugins
"
" See $VIMPATH/bundle for the plugins installed via the pathogen runtimepath
" manager
"
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" General configuration {{{
set cursorline
" set cursorcolumn
set clipboard=unnamedplus " Access the system clipboard
set nobackup
set noswapfile
set nocompatible
set history=1000 " Store a ton of history (default is 20)
set undolevels=1000
set number
set relativenumber
set showmatch
set ruler
set noerrorbells " don't beep
set mouse=a " enable the mouse
set ttymouse=xterm2 " enable dragging of the split border
set ignorecase
set showcmd
set shiftround " round indent to multiple of 'shiftwidth'
set colorcolumn=80
set textwidth=80 " Automatically break lines at X columns
set hidden
set noshowmode " Handled by airline

" Cursor color
" http://vim.wikia.com/wiki/Configuring_the_cursor
highlight Cursor guifg=white guibg=black
highlight iCursor guifg=white guibg=steelblue
set guicursor=n-v-c:block-Cursor
set guicursor+=i:ver100-iCursor
set guicursor+=n-v-c:blinkon0
set guicursor+=i:blinkwait10

" Remap <leader> to comma
let mapleader = ","
nnoremap \ ,

" }}}

" Indentation Related Settings {{{
set smarttab

augroup indentation
    autocmd!
    set tabstop=4
    set shiftwidth=4             " use indents of X spaces
    set preserveindent
    set copyindent
    set softtabstop=4
    set autoindent               " indent at the same level of the previous line
    set expandtab
augroup END

augroup mrpt_indentation
    autocmd!
    " mrpt uses tabs for indentation
    autocmd FileType cpp set tabstop=4
    autocmd FileType cpp set shiftwidth=4 " use indents of X spaces
    autocmd FileType cpp set preserveindent
    autocmd FileType cpp set copyindent
    autocmd FileType cpp set softtabstop=0
    autocmd FileType cpp set autoindent " indent at the same level of the previous line
    autocmd FileType cpp set noexpandtab

    autocmd FileType cpp nmap <Leader>C :ClangFormatAutoToggle<CR>
    autocmd FileType cpp let g:clang_format#command = "/usr/bin/clang-format-3.8"
    autocmd FileType cpp let g:clang_format#detect_style_file = 1
    autocmd FileType cpp let g:clang_format#auto_format_on_insert_leave = 0
    autocmd FileType cpp let g:clang_format#auto_format = 0
    autocmd FileType cpp let g:clang_format#auto_formatexpr = 0
    autocmd FileType cpp set textwidth=0 " Do not automatically break lines

augroup END

set cinoptions+=(0
")  " This is here just to fix the colors from the open parenthesis

augroup yaml_indentation
    autocmd!
    autocmd FileType yaml set tabstop=2
    autocmd FileType yaml set shiftwidth=2             " use indents of X spaces
    autocmd FileType yaml set preserveindent
    autocmd FileType yaml set copyindent
    autocmd FileType yaml set softtabstop=2
    autocmd FileType yaml set autoindent               " indent at the same level of the previous line
    autocmd FileType yaml set expandtab
augroup END

augroup md_indentation
    autocmd!
    autocmd FileType markdown set tabstop=4
    autocmd FileType markdown set shiftwidth=2             " use indents of X spaces
    autocmd FileType markdown set nopreserveindent
    autocmd FileType markdown set nocopyindent
    autocmd FileType markdown set softtabstop=4
    autocmd FileType markdown set noautoindent               " indent at the same level of the previous line
    autocmd FileType markdown set expandtab
augroup END

augroup md_options
	autocmd!
  autocmd FileType markdown call ActivateSpelling()

  " Replace the heading
  autocmd Filetype markdown onoremap ih :<c-u>execute "normal! ?^==\\+$\r:nohlsearch\rkvg_"<cr>
augroup END
" }}}


nnoremap <C-\> <C-t>

" Tab handling {{{
nnoremap <C-t> :tabnew<Space>
nnoremap <C-n> :tabnext<CR>
nnoremap <C-p> :tabprev<CR>
vnoremap <C-t> <ESC>:tabnew<Space>
vnoremap <C-n> <ESC>:tabnext<CR>
vnoremap <C-p> <ESC>:tabprev<CR>
"inoremap <C-t> <ESC>:tabnew<Space>
"inoremap <C-n> <ESC>:tabnext<CR>
"inoremap <C-p> <ESC>:tabprev<CR>
cnoremap <C-t> <ESC>:tabnew<Space>
cnoremap <C-n> <ESC>:tabnext<CR>
cnoremap <C-p> <ESC>:tabprev<CR>

" splits handling - Same as tmux
nnoremap <C-w>\| <ESC>:vsplit<CR>
nnoremap <C-w>- <ESC>:split<CR>

" }}}



" DragVisuals Configuration
" Use the VISUAL LINES!
vnoremap  <expr>  <LEFT>   DVB_Drag('left')
vnoremap  <expr>  <RIGHT>  DVB_Drag('right')
vnoremap  <expr>  <DOWN>   DVB_Drag('down')
vnoremap  <expr>  <UP>     DVB_Drag('up')
vnoremap  <expr>  D        DVB_Duplicate()


" Pathongen package manager {{{

set sessionoptions-=options

let g:pathogen_disabled = ['YouCompleteMe']

" OS-specific vim bundles {{{
" http://stackoverflow.com/a/6847015/2843583
let os = substitute(system('uname'), "\n", "", "")
" OSX {{{
if os == "Darwin"
    " Disable YCM
    " http://stackoverflow.com/questions/4261785/temporarily-disable-some-plugins-using-pathogen-in-vim
    call add(g:pathogen_disabled, 'YouCompleteMe')
    " }}}
    " Linux {{{
elseif os == "Linux"
    " nothing here yet."
endif
" }}}
" }}}


call pathogen#infect()
call pathogen#helptags()

" }}}

" use specific indentation rules per language
filetype indent plugin on
filetype indent on

" Folding in markers for vim {{{
augroup filetype_vim
    autocmd! FileType vim setlocal foldmethod=marker
augroup END
" }}}

"get syntax highlighting
syntax on
set t_Co=256 " make terminator + vim combination


" Colorscheme {{{
set background=dark
"colorscheme neverness
"colorscheme monokai
colorscheme molokai
"colorscheme elda
"colorscheme holokai
"colorscheme vividchalk
"colorscheme SlateDark
"colorscheme summerfruit256
"colorscheme tir_black
"colorscheme solarized
"colorscheme revolutions
"colorscheme reloaded
"
" }}}

" source $MYVIMRC reloads the saved $MYVIMRC
nnoremap <Leader>aa :source $MYVIMRC <CR>

" Relative numbering {{{
function! NumberToggle()
if(&relativenumber == 1)
    set norelativenumber
    set number
else
    set number
    set relativenumber
endif
endfunc

nnoremap <leader>n :call NumberToggle()<cr>
" }}}

" Easy redoing
nnoremap U :redo<CR>
nnoremap <c-r> <nop>


" Quick exit command
noremap <Leader>e :quit<CR> " Quit current window
noremap <Leader>E :qa!<CR> "Quit all windows

" easier moving of code blocks
vnoremap < <gv
vnoremap > >gv

" https://vi.stackexchange.com/questions/2867/how-do-you-chomp-a-string-in-vim
function! Chomp(string)
    return substitute(a:string, '\n\+$', '', '')
endfunction
function! ChompedSystem( ... )
    return substitute(call('system', a:000), '\n\+$', '', '')
endfunction

function! GetGccVersion()
    let l:gcc_ver = ChompedSystem(
                \ "$(gcc --version | head -n 1 | rev | cut -d' ' -f1 | rev)")

    return l:gcc_ver[0]
endfunction


" Who did this.
""""""""""""""""
function! WriteWhoDidThis()
    let l:name = "Nikos Koukis"
    let l:curDate = ChompedSystem('date')
    let l:fullStr = l:curDate . ' - ' . l:name
    :put=l:fullStr
    :Commentary " take care of the comment type
endfunc

nnoremap <F12> :call WriteWhoDidThis()<CR>

" Tabularize Configuration
nnoremap <leader>tt :Tabularize /
vnoremap <leader>tt :Tabularize /
autocmd VimEnter * AddTabularPattern 1=    /^[^=]*\zs=
autocmd VimEnter * AddTabularPattern 1==   /^[^=]*\zs=/r0c0l0

" Tagbar"
nnoremap <leader>to :TagbarToggle<CR>
" Start with tagbar disabled, and open tagbar at all the vim buffers afterwards
map <leader>To :tabdo :Tagbar<CR>
map <leader>TO :tabdo :TagbarClose<CR>

" autocmd BufWinEnter * Tagbar

" Statusline - Airline configuration at last {{{
set laststatus=2
let g:airline#extensions#tabline#enabled = 0
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#left_sep = ' '
let g:airline#extensions#tabline#left_alt_sep = '|'
let g:airline#extensions#hunks#enabled=1
let g:airline#extensions#branch#enabled=1
let g:airline_theme='dark' " https://github.com/vim-airline/vim-airline/wiki/Screenshots
let g:airline_highlighting_cache = 0

" " highlight current tab
" hi TabLineFill ctermfg=LightGreen ctermbg=DarkGreen
" hi TabLine ctermfg=Black ctermbg=Green
" hi TabLineSel ctermfg=LightBlue


" set statusline+=%#warningmsg#
" set statusline+=%{SyntasticStatuslineFlag()}
" set statusline+=%*

" }}}



if !exists('g:airline_symbols')
	let g:airline_symbols = {}
endif
let g:airline_symbols.space = "\ua0"

" Resetting the <ESC> key.. at last
nnoremap <C-{> <ESC>
vnoremap <C-{> <ESC>
inoremap <C-{> <ESC>


" Changing the default title - courtesy of http://www.dotfiles.org/~inty/.vimrc
if has('title')
	set titlestring=
	set titlestring+=%f\                     " file name
	set titlestring+=%h%m%r%w                " flags
	set titlestring+=\ -\ %{v:progname}      " program name
	set titlestring+=\ -\ %{substitute(getcwd(),\ $HOME,\ '~',\ '')} " working directory
endif

" Searching Configuration
set incsearch
set hlsearch
"
" Clear highlights
nnoremap <silent><leader>/ :noh<return><CR>



" Fri Jun 19 15:53:20 EEST 2015, Nikos Koukis
" Courtesy of tpope, sensible.vim
if !&scrolloff
	set scrolloff=1
endif
if !&sidescrolloff
	set sidescrolloff=5
endif
set display+=lastline

if &encoding ==# 'latin1' && has('gui_running')
	set encoding=utf-8
endif

set backspace=indent,eol,start
set complete-=i

""""""""""""""""""
" Matlab Editing "
""""""""""""""""""
source $VIMRUNTIME/macros/matchit.vim

"""""""""""""""""""
" Various Commmands
"""""""""""""""""""

" doesn't work by default for some reason
nnoremap ag :ascii<CR>

" markdown support
"""""""""""""""""""
let g:vim_markdown_folding_disabled=1
let g:vim_markdown_math=1
let g:vim_markdown_frontmatter=1
map <F5> :!markdown README.md > a.html && open a.html <CR>

" automatic folding off
"""""""""""""""""""""""
set foldmethod=indent
set foldlevel=20

" Arduino Configuration
"map <leader><leader>u :ArduinoVerify <CR>
"map <leader><leader>y :ArduinoUpload <CR>

"map <leader>c :w !pbcopy<CR><CR>
set pastetoggle=<F2> " Super useful.


" NERDTREE - Comeback
map  <leader><leader>n :NERDTree <CR>
nnoremap <Leader>d :let NERDTreeQuitOnOpen = 1<bar>NERDTreeToggle<CR>
nnoremap <Leader>D :let NERDTreeQuitOnOpen = 0<bar>NERDTreeToggle<CR>

let g:pydoc_open_cmd = 'split'

" Python Syntax Support - as basic as possible
" flake8
let g:flake8_quickfix_height=3
"autocmd BufWritePost *.py call Flake8() " Call Flake8 every time you run python
autocmd FileType python map <buffer> <leader><leader>f :call Flake8()<CR>

" to use colors defined in the colorscheme
highlight link Flake8_Error      Error
highlight link Flake8_Warning    WarningMsg
highlight link Flake8_Complexity WarningMsg
highlight link Flake8_Naming     WarningMsg
highlight link Flake8_PyFlake    WarningMsg

" Syntastic python
let g:syntastic_python_checkers=['flake8']
let g:syntastic_vim_checkers = ['vint']
let g:flake8_error_marker='EE'     " set error marker to 'EE'
let g:flake8_warning_marker='WW'   " set warning marker to 'WW'
let g:syntastic_python_flake8_args='--ignore=W391,W291,W293,E303,
            \ E265,E261,E113,E501,W503'
let g:syntastic_aggregate_errors = 1
let g:syntastic_always_populate_loc_list = 0
let g:syntastic_auto_loc_list = 1
let g:syntastic_loc_list_height = 3
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

" Syntastic - LaTex
let g:syntastic_tex_checkers = ['lacheck', 'text/language_check']


" Syntastic - c=+11
let g:syntastic_c_compiler = 'gcc'
let g:syntastic_c_no_default_include_dirs = 0
let g:syntastic_c_auto_refresh_includes = 1
let g:syntastic_c_checkers = ['clang_tidy', 'gcc', ]

let g:syntastic_cpp_checkers = ['clang_tidy', 'gcc', 'cpplint',]
let g:syntastic_cpp_compiler = 'g++'
let g:syntastic_cpp_compiler_options = ' -std=c++11 -stdlib=libc++'
let g:syntastic_cpp_no_default_include_dirs = 0
let g:syntastic_cpp_auto_refresh_includes = 1
let g:syntastic_cpp_check_header = 1

let g:syntastic_cpp_cpplint_args = "--verbose=5"
let g:syntastic_cpp_cpplint_exec = "cpplint"
let g:syntastic_clang_tidy_config_file='~/.syntastic_clang_tidy.cfg'

" latex project custom compilation
map <leader><leader>t :set nocursorline<CR>
                    \ :set nocursorcolumn<CR>
map <leader><leader>s :!./makeLatex.py 1&>/dev/null&<CR>
map <eader><leader>σ :!./makeLatex.py 1&>/dev/null&<CR>
map <leader><leader>a :!./makeLatex.py<CR>
map <leader><leader>α :!./makeLatex.py<CR>

let g:Tex_CompileRule_pdf = 'xelatex $*'

"DEPRECATED - Show the current filename
map <leader>2 :echo @%<CR>
" Convert slashes to backslashes for Windows.
" http://vim.wikia.com/wiki/VimTip600
if has('win32')
  nmap ,cs :let @*=substitute(expand("%"), "/", "\\", "g")<CR>
  nmap ,cl :let @*=substitute(expand("%:p"), "/", "\\", "g")<CR>

  " This will copy the path in 8.3 short format, for DOS and Windows 9x
  nmap <leader>c8 :let @+=substitute(expand("%:p:8"), "/", "\\", "g")<CR>
else
  nmap <leader>cs :let @+=expand("%")<CR>
  nmap <leader>cl :let @+=expand("%:p")<CR>
endif

if has("gui_running")
    " GUI is running or is about to start.
    " Maximize gvim window (for an alternative on Windows, see simalt below).
    set lines=999 columns=999
endif

" Mon Feb 29 00:09:09 EET 2016, Nikos Koukis
" AutoPairs - https://github.com/jiangmiao/auto-pairs
let g:AutoPairsFlyMode = 0
let g:AutoPairsShortcutToggle = '<leader>ap'

" Mon Apr 4 15:31:29 EEST 2016, Nikos Koukis
" clang configuration
"let g:clang_jumpto_back_key = '<leader><leader>t'

" ignore case in filename completion
" http://stackoverflow.com/questions/3686841/vim-case-insensitive-filename-completion
set wildignorecase
" bash like autocompletion
set wildmode=longest,list

" Wed Apr 6 10:01:54 EEST 2016, Nikos Koukis
" different indentation for cpp code (also changed the .c, .cpp snippets
map <leader>sc :SyntasticCheck<CR>

" Fri Apr 8 20:18:54 EEST 2016, Nikos Koukis
autocmd VimEnter * so $HOME/.vim/own_scripts/abbreviations.vim

" Sat Apr 9 14:59:33 EEST 2016, Nikos Koukis
" Highlight current word *without* jumping to next occurance
" http://vim.wikia.com/wiki/Highlight_all_search_pattern_matches
nnoremap <leader>hw :let @/='\<<C-R>=expand("<cword>")<CR>\>'<CR>:set hls<CR>

" Sat Apr 9 15:55:15 EEST 2016, Nikos Koukis
" ctrlp is back!!
" https://github.com/ctrlpvim/ctrlp.vim
" Slow to start at first run - creates cachefiles.
" :CtrlPClearAllCaches - clear cache
set runtimepath^=$bundle/ctrlp.vim
set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*.DS_Store,*/\.git/*
let g:ctrlp_working_path_mode = 'ra'
let g:ctrlp_map='<C-s>'

" The maximum number of files to scan, set to 0 for no limit:
let g:ctrlp_max_files=0

" mappings
nnoremap <leader>pp :CtrlP<CR>
nnoremap <leader>pf :CtrlPBuffer<CR>
nnoremap <leader>pm :CtrlPMRU<CR>
" Search through your tags!
nnoremap <leader>pt :CtrlPTag<CR>

" Thu Apr 14 22:10:19 EEST 2016, Nikos Koukis
" indentLine

" Sat Apr 16 16:19:44 EEST 2016, Nikos Koukis
" vim-titlecase
" $VIMPATH/plugin/titlecase.vim

" Sun Apr 17 10:40:49 EEST 2016, Nikos Koukis
" vim-visual-star-search - use */# on visual selection

" Sun Apr 17 20:59:23 EEST 2016, Nikos Koukis
" Installed vim-husk for vim command line emacs-like mappings
" https://github.com/vim-utils/vim-husk

" C-n, C-p to browse the cmdline history in a filtered way
cnoremap <C-p> <Up>
cnoremap <C-n> <Down>

" Octave/Matlab configuration {{{
augroup filetypedetect " This is a special autocommands group do not do autocmd! by itself!!!
	autocmd! BufRead,BufNewFile *.m,*.oct set filetype=matlab
augroup END

" }}}

" Greek Support
""""""""""""""""
" courtesy of vkoukis
set langmap=ΑA,ΒB,ΨC,ΔD,ΕE,ΦF,ΓG,ΗH,ΙI,ΞJ,ΚK,ΛL,ΜM,ΝN,ΟO,ΠP,ΣS,ΤT,ΘU,ΩV,WW,ΧX,ΥY,ΖZ,αa,βb,ψc,δd,εe,φf,γg,ηh,ιi,ξj,κk,λl,μm,νn,οo,πp,qq,ρr,σs,τt,θu,ωv,ςw,χx,υy,ζz


" Wed Jun 24 18:10:15 EEST 2015, Nikos Koukis
nnoremap ,α <leader>a
nnoremap ,ψψ <leader>cc
vnoremap ,ψψ <leader>cc

" arrange lines - up to 80 characters
vnoremap γ; gq

" use %% for accessing files in the path of the current buffer
cnoremap <expr> %% getcmdtype() == ':' ? expand('%:h').'/' : '%%'

autocmd FileType cpp map <buffer> <leader>cp :call Cpplint()<CR>
"autocmd BufWritePost *.h,*.cpp call Cpplint()

" https://robots.thoughtbot.com/5-useful-tips-for-a-better-commit-message
" git commit configuration
autocmd Filetype gitcommit setlocal spell textwidth=72

" toogle spelling
nnoremap <Leader>sp <ESC>:call ActivateSpelling()<CR>
vnoremap <Leader>sp <ESC>:call ActivateSpelling()<CR>
inoremap <Leader>sp <ESC>:call ActivateSpelling()<CR>


" Indentation Configuration {{{

" Return indent (all whitespace at start of a line), converted from
" tabs to spaces if what = 1, or from spaces to tabs otherwise.
" When converting to tabs, result has no redundant spaces.
function! Indenting(indent, what, cols)
  let spccol = repeat(' ', a:cols)
  let result = substitute(a:indent, spccol, '\t', 'g')
  let result = substitute(result, ' \+\ze\t', '', 'g')
  if a:what == 1
	let result = substitute(result, '\t', spccol, 'g')
  endif
  return result
endfunction

" Convert whitespace used for indenting (before first non-whitespace).
" what = 0 (convert spaces to tabs), or 1 (convert tabs to spaces).
" cols = string with number of columns per tab, or empty to use 'tabstop'.
" The cursor position is restored, but the cursor will be in a different
" column when the number of characters in the indent of the line is changed.
function! IndentConvert(line1, line2, what, cols)
  let savepos = getpos('.')
  let cols = empty(a:cols) ? &tabstop : a:cols
  execute a:line1 . ',' . a:line2 . 's/^\s\+/\=Indenting(submatch(0), a:what, cols)/e'
  call histdel('search', -1)
  call setpos('.', savepos)
endfunction
command! -nargs=? -range=% Space2Tab call IndentConvert(<line1>,<line2>,0,<q-args>)
command! -nargs=? -range=% Tab2Space call IndentConvert(<line1>,<line2>,1,<q-args>)
command! -nargs=? -range=% RetabIndent call IndentConvert(<line1>,<line2>,&et,<q-args>)

" }}}

" do it only when you have a good reason to.
"set list
set listchars=eol:¬,tab:>·,trail:~,extends:>,precedes:<

" DEPRECATED - Use vim-trailing-whitespace
" " Highlight extra whitespaces - persistent even when set  before colorscheme
" autocmd colorscheme * highlight ExtraWhitespace ctermbg=darkgreen guibg=darkgreen
" highlight ExtraWhitespace ctermbg=darkgreen guibg=darkgreen

" " Show spaces used for indenting (so you use only tabs for indenting).
" match ExtraWhitespace /^\t*\zs \+/
" " Show trailing whitespace:
" match ExtraWhitespace /\s\+$/
" function! ShowSpaces(...)
"   let @/='\v(\s+$)|( +\ze\t)'
"   let oldhlsearch=&hlsearch
"   if !a:0
"     let &hlsearch=!&hlsearch
"   else
"     let &hlsearch=a:1
"   end
"   return oldhlsearch
" endfunction

function! TrimSpaces() range
  let oldhlsearch=ShowSpaces(1)
  execute a:firstline.",".a:lastline."substitute ///gec"
  let &hlsearch=oldhlsearch
endfunction

command! -bar -nargs=? ShowSpaces call ShowSpaces(<args>)
command! -bar -nargs=0 -range=% TrimSpaces <line1>,<line2>call! TrimSpaces()
nnoremap <leader>ss  :ShowSpaces 1<CR>
nnoremap <leader>ts  m`:TrimSpaces<CR>``
vnoremap <leader>ts  :TrimSpaces<CR>

" c++ code completion
"""""""""""""""""""""""""""""""""""""""""""""""""""""

map <leader>rt :!ctags -R --fields=+l --tag-relative . <CR>
set completeopt=menuone,menu,longest,preview

" omni-completion - where to search ...
" https://www.youtube.com/watch?v=3TX3kV3TICU
set complete=.,w,b,u,t,i,kspell

" Mappings for moving around the vimtabs
nnoremap <leader><C-p> :tabm -1<CR>
nnoremap <leader><C-n> :tabm +1<CR>
nnoremap <leader><leader><C-p> :tabm 0<CR>
nnoremap <leader><leader><C-n> :tabm 99<CR>

" Jedi vim configuration
let g:jedi#popup_select_first = 1
let g:jedi#show_call_signatures = "1"
let g:jedi#documentation_command = "K"


" Redraw the screen
nnoremap <leader><leader>r :redraw!<CR>

" go to last vim tab
" http://stackoverflow.com/questions/2119754/switch-to-last-active-tab-in-vim
let g:lasttab = 1
nnoremap <Leader>t- :exe "tabn ".g:lasttab<CR>
au TabLeave * let g:lasttab = tabpagenr()

" Mutt configuration {{{
" TODO autocompletion in vim for mutt mail composing
" https://dev.mutt.org/trac/wiki/ConfigTricks

autocmd BufNewFile,BufRead ~/.mutt/temp/mutt* call SetMuttConfig()
function! SetMuttConfig()
    :source ~/.mutt/lbdbq.vim
    call ActivateSpelling()
endfunc

" }}}

autocmd Filetype tex call SetLatexConfig()
function! SetLatexConfig()
    set textwidth=80
    call ActivateSpelling()
endfunc

function! ActivateSpelling()
    " spelling support
    :set spelllang=en,el
    :set spell
    :Americanize
endfunc

" vim-latex configuration
let g:Tex_GotoError = 0
let g:Tex_ShowErrorContext = 0

" vim-maximiser {{{
  let g:maximizer_set_default_mapping = 1
nnoremap <silent><leader>tz :MaximizerToggle<CR>
vnoremap <silent><leader>tz :MaximizerToggle<CR>gv
inoremap <silent><leader>tz <C-o>:MaximizerToggle<CR>
" }}}

autocmd VimLeavePre * cclose | lclose

" vim-taskwarrior plugin configuration {{{
" https://github.com/blindFS/vim-taskwarrior
let g:task_rc_override = 'rc.defaultwidth=0' " line-wrapping

" }}}

" Rust configuration {{{
let g:rustfmt_autosave = 1

" }}}

" https://github.com/racer-rust/vim-racer
let g:racer_cmd = "$HOME/.cargo/bin/racer"
let g:racer_experimental_completer = 1 " Experimental
au FileType rust nmap gd <Plug>(rust-def)
au FileType rust nmap gs <Plug>(rust-def-split)
au FileType rust nmap gx <Plug>(rust-def-vertical)
au FileType rust nmap <leader>gd <Plug>(rust-doc)

set tags+=./tags;,tags;/

" Sun 21 Jan 14:50:51 GMT 2018 - Nikos Koukis
" Don't Use YCM. This plugin is bloated, demands too many configuration steps
" YCM {{{
" and when isn't as effective as it needs.
"
" let g:ycm_key_list_select_completion = ['<C-n>', '<Down>']
" let g:ycm_key_list_previous_completion = ['<C-p>', '<Up>']
" let g:ycm_collect_identifiers_from_tags_files=1
" let g:ycm_global_ycm_extra_conf="~/.ycm_extra_conf.py"
" let g:ycm_confirm_extra_conf=0

" let g:ycm_python_binary_path='python'
" }}}

" vim-clang {{{
" let g:clang_c_options = '-std=gnu11'
" let g:clang_cpp_options = '-std=c++11 -stdlib=libc++ -I/usr/include/c++'
let g:clang_compilation_database = '/home/berger/mrpt_build/'

" }}}

"let g:SuperTabDefaultCompletionType = '<C-n>'

" Trigger configuration. Do not use <tab> if you use https://github.com/Valloric/YouCompleteMe.
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<s-tab>"

" If you want :UltiSnipsEdit to split your window.
let g:UltiSnipsEditSplit="vertical"

" DEPRECATED
"
" vim-geeknote configuration
" Just don't use it...

function! MakeTmpFile()
    let $a = system('mktemp --suffix ".markdown"')
    :tabnew $a
endfunc
nnoremap <leader>mk :call MakeTmpFile()<CR>


" Open URLs in your browser
function! HandleURL()
    let s:uri = matchstr(getline("."), '[a-z]*:\/\/[^ >,;]*')
    echo s:uri
    if s:uri != ""
        silent exec "!xdg-open '".s:uri."'"
    else
        echo "No URI found in line."
    endif
endfunction
map <leader>u :call HandleURL()<CR>

" bullets.vim - Markdown plugin for correct indentation of bullet lists
" https://github.com/dkarter/bullets.vi://github.com/dkarter/bullets.vim
" Use C-d/C-t for indenting outwards/inwards
" In visual: :RenumberSelection

" vim-autoformat
" https://github.com/Chiel92/vim-autoformat
noremap <leader>af :Autoformat<CR>
let g:formatter_yapf_style = 'pep8'


" vimproc.vim
" You need to run **make** prior to running this
" https://github.com/Shougo/vimproc.vim.git ~/.vim/bundle/vimproc.vim


" vim2hs - Haskell multipurpose plugin
" https://github.com/dag/vim2hs
let g:haskell_conceal_wide = 1
let g:haskell_tabular = 1
let g:hpaste_author = 'Nikos Koukis - bergercookie'

" " Easy-Align {{{
" " https://github.com/junegunn/vim-easy-align
" " Start interactive EasyAlign in visual mode (e.g. vipga)
" xnoremap ga <Plug>(EasyAlign)
" " Start interactive EasyAlign for a motion/text object (e.g. gaip)
" nnoremap ga <Plug>(EasyAlign)
" }}}

" vim-indent-guides
let g:indent_guides_enable_on_vim_startup = 1
let g:indent_guides_start_level = 2
let g:indent_guides_guide_size = 1

let g:hindent_on_save = 1
let g:hindet_indent_size = 2
let g:hindent_line_length = 80

" Fucntions for Writing debug messages {{{
function! MessageCMake(var)
    let l:cmakeVar = "message(\"" . a:var . ": ${" . a:var . "}\")"
    :put=l:cmakeVar
endfunc
nnoremap <Leader>cM :call MessageCMake("

function! MessageCpp(var)
    let l:debugStrPrior =  " << " . a:var . " << std::endl;"
    let l:debug_str = "std::cout << \" " . a:var . ":\" " . l:debugStrPrior
    :put=l:debug_str
endfunc
nnoremap <Leader>cP :call MessageCpp("

" }}}

" Goyo - Distraction free writing in vim _{{{
" https://github.com/junegunn/goyo.vim
" Type :Goyo
" }}}

" Terminus {{{
" Adding minor important capabilities to vim
" https://github.com/wincent/terminus
" }}}

" Focus reporting {{{
" Improved mouse support
" Bracketted paste
" }}}

" commentary.vim {{{
" https://github.com/tpope/vim-commentaryhttps://github.com/tpope/vim-commentary
" }}}

" vim-eunoch {{{
" helpers for UNIX
" https://github.com/t<F20>pope/vim-eunuch
" }}}

" vim-unimpaired {{{
" https://github.com/tpope/vim-unimpaired
" }}}


" ctags configuration {{{

" ctags support for ansible
let g:tagbar_type_ansible = {
	\ 'ctagstype' : 'ansible',
	\ 'kinds' : [
		\ 't:tasks'
	\ ],
	\ 'sort' : 0
\ }

" ctags support for haskell
let g:tagbar_type_haskell = {
    \ 'ctagsbin'  : 'hasktags',
    \ 'ctagsargs' : '-x -c -o-',
    \ 'kinds'     : [
        \  'm:modules:0:1',
        \  'd:data: 0:1',
        \  'd_gadt: data gadt:0:1',
        \  't:type names:0:1',
        \  'nt:new types:0:1',
        \  'c:classes:0:1',
        \  'cons:constructors:1:1',
        \  'c_gadt:constructor gadt:1:1',
        \  'c_a:constructor accessors:1:1',
        \  'ft:function types:1:1',
        \  'fi:function implementations:0:1',
        \  'o:others:0:1'
    \ ],
    \ 'sro'        : '.',
    \ 'kind2scope' : {
        \ 'm' : 'module',
        \ 'c' : 'class',
        \ 'd' : 'data',
        \ 't' : 'type'
    \ },
    \ 'scope2kind' : {
        \ 'module' : 'm',
        \ 'class'  : 'c',
        \ 'data'   : 'd',
        \ 'type'   : 't'
    \ }
\ }

" ctags support for makefiles
let g:tagbar_type_make = {
            \ 'kinds':[
                \ 'm:macros',
                \ 't:targets'
            \ ]
\}

" ctags support for markdown
let g:tagbar_type_markdown = {
    \ 'ctagstype' : 'markdown',
    \ 'kinds' : [
        \ 'h:Heading_L1',
        \ 'i:Heading_L2',
        \ 'k:Heading_L3'
    \ ]
\ }

" ctags support for mediawiki
 let g:tagbar_type_mediawiki = {
    \ 'ctagstype' : 'mediawiki',
    \ 'kinds' : [
        \'h:chapters',
        \'s:sections',
        \'u:subsections',
        \'b:subsubsections',
    \]
    \}

 " ctags support for rst
let g:tagbar_type_rst = {
    \ 'ctagstype': 'rst',
    \ 'ctagsbin' : '~/dotfiles/tools/rst2ctags/rst2ctags.py',
    \ 'ctagsargs' : '-f - --sort=yes',
    \ 'kinds' : [
        \ 's:sections',
        \ 'i:images'
    \ ],
    \ 'sro' : '|',
    \ 'kind2scope' : {
        \ 's' : 'section',
    \ },
    \ 'sort': 0,
\ }

" }}}

" undotree - like GUndo {{{
nnoremap <leader>ut :UndotreeToggle<CR>
" }}}

" tmux-integration plugins {{{
" Sat Dec 9 20:05:59 GMT 2017, Nikos Koukis
" tmux-completer - Never actually worked..

" vim-tmux-navigator
" Disable tmux navigator when zooming the Vim pane
let g:tmux_navigator_disable_when_zoomed = 1
let g:tmux_navigator_save_on_switch = 1

" vim-tmux-runner
let g:VtrStripLeadingWhitespace = 0
let g:VtrClearEmptyLines = 0
let g:VtrAppendNewline = 1

nmap <leader>tr :VtrSendLinesToRunner<CR>
vmap <leader>tr <Esc>:VtrSendLinesToRunner<CR>
"
" }}}


" vim-signature {{{
let g:SignatureMarkTextHLDynamic=1

" " Using Marks
" nnoremap <leader>k :marks<CR>
" vnoremap <leader>k <ESC>:marks<CR>
" inoremap <leader>k <ESC>:marks<CR>

" }}}

" vim-fugitive {{{
" Show the glog results in the quickfix window by :copen after glog
" }}}

" vim-autotags {{{
" Didn't work in my case...
" }}}

" https://stackoverflow.com/questions/19430200/how-to-clear-vim-registers-effectively
command! WipeReg for i in range(34,122) | silent! call setreg(nr2char(i), []) | endfor


" Wrappers for opening the quickfix window automatically after execution (e.g.,
" grep, glog, ...)

set viminfo='100,<50,s10,h,n$HOME/.vim/files/info/viminfo
