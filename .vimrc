""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Fri Dec 29 12:51:00 EET 2017 - Nikos Koukis
" This is the main vimrc file used both in my linux and mac machines.
"  - Formmatting
"  - Syntax
"  - Automation procedures
"  - Loading plugins
"
"  For plugin configuration I use vim-plug - see the Plug '...' lines for the
"  plugins in use.
"
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Basic configuration {{{
" Very basic configuration {{{
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
if !has('nvim')
    set ttymouse=xterm2
endif
set ignorecase
set showcmd
set shiftround " round indent to multiple of 'shiftwidth'
set colorcolumn=80
set textwidth=80 " Automatically break lines at X columns
set hidden
set noshowmode " Handled by airline
set viminfo='100,<50,s10,h,n$HOME/.viminfo
if !has('nvim')
    set viminfo+=!  " Compatible viminfo file in both vim and neovim
endif
" ignore case in filename completion
" http://stackoverflow.com/questions/3686841/vim-case-insensitive-filename-completion
set wildignorecase
" bash like autocompletion
set wildmode=longest,full
set backspace=indent,eol,start
set complete-=i
set pastetoggle=<F2>
set tabpagemax=100  " max tabs on :tab all

" use specific indentation rules per language
filetype indent plugin on
filetype indent on
" Syntax highlighting
syntax on
set t_Co=256 " make terminator + vim combination
" Remap <leader> to comma {{{
let mapleader = ","
nnoremap \ ,
" }}}
" Searching Configuration {{{
set incsearch
set inccommand=split
set hlsearch
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
" }}}


" }}}

" do it only when you have a good reason to.
set listchars=eol:¬,tab:>·,trail:~,extends:>,precedes:<
" Cursor color {{{
" http://vim.wikia.com/wiki/Configuring_the_cursor
highlight Cursor guifg=white guibg=black
highlight iCursor guifg=white guibg=steelblue
set guicursor=n-v-c:block-Cursor
set guicursor+=i:ver100-iCursor
set guicursor+=n-v-c:blinkon0
set guicursor+=i:blinkwait10
" }}}
" use %% for accessing files in the path of the current buffer
cnoremap <expr> %% getcmdtype() == ':' ? expand('%:h').'/' : '%%'
" Redraw the screen
nnoremap <leader><leader>r :redraw!<CR>
autocmd VimLeavePre * cclose | lclose
" Clean registers - https://stackoverflow.com/questions/19430200/how-to-clear-vim-registers-effectively
command! WipeReg for i in range(34,122) | silent! call setreg(nr2char(i), []) | endfor

" Indent on opening parentheses
set cinoptions+=(0
")  " This is here just to fix the colors from the open parenthesis
" }}}
" Tab handling {{{
nnoremap <C-\> <C-t>
nnoremap <C-t> :tabnew<Space>
nnoremap <C-n> :tabnext<CR>
nnoremap <C-p> :tabprev<CR>
vnoremap <C-t> <ESC>:tabnew<Space>
vnoremap <C-n> <ESC>:tabnext<CR>
vnoremap <C-p> <ESC>:tabprev<CR>
cnoremap <C-t> <ESC>:tabnew<Space>
cnoremap <C-n> <ESC>:tabnext<CR>
cnoremap <C-p> <ESC>:tabprev<CR>

" splits handling - Same as tmux
nnoremap <C-w>\| <ESC>:vsplit<CR>
nnoremap <C-w>- <ESC>:split<CR>

" Mappings for moving around the vimtabs
nnoremap <leader><C-p> :tabm -1<CR>
nnoremap <leader><C-n> :tabm +1<CR>
nnoremap <leader><leader><C-p> :tabm 0<CR>
nnoremap <leader><leader><C-n> :tabm<CR>
" go to last vim tab
" http://stackoverflow.com/questions/2119754/switch-to-last-active-tab-in-vim
let g:lasttab = 1
nnoremap <Leader>t- :exe "tabn ".g:lasttab<CR>
au TabLeave * let g:lasttab = tabpagenr()
" }}}
" vim-plug package manager {{{

" How to delete a plugin?
"
" 1. Delete or comment out Plug commands for the plugins you want to remove.
" 2. Reload vimrc (:source ~/.vimrc) or restart Vim
" 3. Run :PlugClean. It will detect and remove undeclared plugins.


" Automate the installation of vim-plug
" https://github.com/junegunn/vim-plug/wiki/tips#automatic-installation
if empty(glob('~/.vim/autoload/plug.vim'))
    silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
                \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin()
Plug 'junegunn/vim-plug'
Plug 'https://github.com/ervandew/supertab'
Plug 'https://github.com/tpope/vim-surround'
Plug 'https://github.com/tpope/vim-abolish'
Plug 'https://github.com/vim-airline/vim-airline-themes'
Plug 'https://github.com/PeterRincker/vim-argumentative'
Plug 'https://github.com/tpope/vim-obsession'
Plug 'https://github.com/wesQ3/vim-windowswap'
Plug 'https://github.com/tpope/vim-speeddating'
Plug 'https://github.com/godlygeek/tabular'
Plug 'https://github.com/majutsushi/tagbar'
Plug 'https://github.com/vim-airline/vim-airline'
Plug 'https://github.com/terryma/vim-expand-region'
Plug 'https://github.com/vim-latex/vim-latex', {'for': ['latex', ]}
Plug 'https://github.com/tpope/vim-fugitive'
Plug 'https://github.com/rhysd/vim-clang-format'
Plug 'https://github.com/tpope/vim-dispatch'
Plug 'https://github.com/tomtom/tlib_vim.git'
Plug 'https://github.com/MarcWeber/vim-addon-mw-utils'
Plug 'https://github.com/tomtom/tlib_vim.git'
Plug 'https://github.com/hynek/vim-python-pep8-indent.git'
Plug 'https://github.com/tpope/vim-repeat'
Plug 'https://github.com/szw/vim-maximizer.git'
Plug 'https://github.com/pearofducks/ansible-vim'
Plug 'https://github.com/davidbeckingsale/writegood.vim'
Plug 'https://github.com/SirVer/ultisnips'
Plug 'https://github.com/rust-lang/rust.vim'
Plug 'https://github.com/racer-rust/vim-racer'
Plug 'https://github.com/nickhutchinson/vim-cmake-syntax'
Plug 'https://github.com/plasticboy/vim-markdown'
Plug 'https://github.com/dkarter/bullets.vim', {'for': ['markdown', 'rst', 'vimwiki']}
Plug 'https://github.com/Chiel92/vim-autoformat'
Plug 'https://github.com/kana/vim-operator-user'
Plug 'https://github.com/Shougo/vimproc.vim', {'do': 'make'}
Plug 'https://github.com/dag/vim2hs', {'for': ['haskell', ]}
Plug 'https://github.com/eagletmt/ghcmod-vim', {'for': ['haskell', ]}
Plug 'https://github.com/eagletmt/neco-ghc', {'for': ['haskell', ]}
Plug 'https://github.com/Shougo/neco-vim'
Plug 'https://github.com/itchyny/vim-haskell-indent'
Plug 'https://github.com/AndrewRadev/undoquit.vim'
Plug 'https://github.com/tpope/vim-commentary'
Plug 'https://github.com/mbbill/undotree/'
Plug 'https://github.com/wincent/terminus'
Plug 'https://github.com/tpope/vim-eunuch'
Plug 'https://github.com/ciaranm/detectindent'
Plug 'https://github.com/kshenoy/vim-signature'
Plug 'https://github.com/bronson/vim-trailing-whitespace'
Plug 'https://github.com/airblade/vim-gitgutter'
Plug 'https://github.com/tpope/vim-projectionist'
Plug 'https://github.com/tpope/vim-scriptease'
Plug 'git://github.com/jiangmiao/auto-pairs.git'
Plug 'https://github.com/tommcdo/vim-exchange'
Plug 'https://github.com/nelstrom/vim-markdown-folding'
Plug 'https://github.com/tmux-plugins/vim-tmux-focus-events'
Plug 'https://github.com/tmux-plugins/vim-tmux'
Plug 'https://github.com/christoomey/vim-tmux-navigator'
Plug 'https://github.com/roxma/vim-tmux-clipboard'
Plug 'https://github.com/wellle/tmux-complete.vim', {'do': ':UpdateRemotePlugins'}
Plug 'https://github.com/Yggdroot/indentLine'
Plug 'https://github.com/google/vimdoc'
Plug 'https://github.com/junegunn/vader.vim'
Plug 'https://github.com/janko-m/vim-test'
Plug 'https://github.com/andymass/vim-matchup'
Plug 'https://github.com/vim-utils/vim-man', {'tag': 'v0.1.0'}
Plug 'zchee/deoplete-jedi', {'do': 'UpdateRemotePlugins'}
Plug 'sebastianmarkow/deoplete-rust'
Plug 'zchee/deoplete-clang'
Plug 'https://github.com/Shougo/neoinclude.vim'
Plug 'arakashic/chromatica.nvim'
Plug 'https://github.com/tpope/vim-rsi'
Plug 'w0rp/ale'
" For GBrowse
Plug 'https://github.com/tommcdo/vim-fubitive'
Plug 'https://github.com/tpope/vim-rhubarb'
" Multi-entry selection UI. FZF
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
" deoplete
if has('nvim')
  Plug 'Shougo/deoplete.nvim', {'do': ':UpdateRemotePlugins'}
else
  Plug 'Shougo/deoplete.nvim'
  Plug 'roxma/nvim-yarp'
  Plug 'roxma/vim-hug-neovim-rpc'
endif
Plug 'https://github.com/jwilm/i3-vim-focus'
Plug 'https://github.com/NLKNguyen/papercolor-theme'
Plug 'https://github.com/christoomey/vim-titlecase'

" vimwiki, taskwiki + dependencies
Plug 'https://github.com/vimwiki/vimwiki', { 'branch': 'dev' }
Plug 'https://github.com/tbabej/taskwiki'
Plug 'https://github.com/farseer90718/vim-taskwarrior',  { 'on': 'VimwikiIndex' }

" text objects general configuration {{{
"
" See list of available text objects by the community:
" https://github.com/kana/vim-textobj-user/wiki
Plug 'kana/vim-textobj-user'
Plug 'whatyouhide/vim-textobj-xmlattr'
Plug 'https://github.com/kana/vim-textobj-indent' " ai/ii, aI/iI
Plug 'https://github.com/kana/vim-textobj-line' " al/il
Plug 'https://github.com/adriaanzon/vim-textobj-matchit' " am/im
Plug 'https://github.com/glts/vim-textobj-comment' " ac/ic/iC
Plug 'https://github.com/thinca/vim-textobj-between' " af/if
Plug 'https://github.com/Julian/vim-textobj-variable-segment' " av/iv
" Plug 'https://github.com/fvictorio/vim-textobj-backticks' " a`/i`, works multiline
Plug 'https://github.com/jceb/vim-textobj-uri' " au/iu
" Plug 'https://github.com/kana/vim-textobj-diff' " adh/idh - doesn't' look interesting
" Plug 'vim-textobj-blanklines' " Use `ip` instead
" Plug 'https://github.com/kana/vim-textobj-syntax' "ay/iy TODO
" Plug 'https://github.com/kana/vim-textobj-help' " for :help pages
" Plug 'https://github.com/bps/vim-textobj-python' " af/if, ac/ic TODO

" }}}

" own + maintained version's
Plug 'git@github.com:bergercookie/vim-snippets'
Plug 'git@github.com:bergercookie/vim-debugstring'
Plug 'git@github.com:bergercookie/vim-britishise'
Plug 'git@github.com:bergercookie/describe.nvim'
" Plug 'https://github.com/jacobsimpson/nvim-example-python-plugin'

" Automatically executes filetype plugin indent on and syntax enable. You can
" revert the settings after the call. e.g. filetype indent off, syntax off, etc
call plug#end()
" }}}
" Colorscheme {{{
" See :Colors<CR> for selecting another colorscheme
set background=dark
colorscheme PaperColor
" colorscheme molokai
" autocmd ColorScheme janah highlight Normal ctermbg=235 | colorscheme janah
" }}}
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
" Various handy remappings {{{
" source $MYVIMRC reloads the saved $MYVIMRC
nnoremap <Leader>aa :source $MYVIMRC <CR>
" Exit vim (wo saving)
nnoremap <leader>e :q<CR>
" Easy redoing
nnoremap U :redo<CR>
nnoremap <c-r> <nop>

" Clear search highlights
nnoremap <silent><leader>/ :noh<return><CR>

" Keep visual selection when moving blocks left and right
vnoremap < <gv
vnoremap > >gv

" Sat Apr 9 14:59:33 EEST 2016, Nikos Koukis
" Highlight current word *without* jumping to next occurance
" http://vim.wikia.com/wiki/Highlight_all_search_pattern_matches
nnoremap <leader>hw :let @/='\<<C-R>=expand("<cword>")<CR>\>'<CR>:set hls<CR>

" C-n, C-p to browse the cmdline history in a filtered way
cnoremap <C-p> <Up>
cnoremap <C-n> <Down>

" Show the current filename
nnoremap <leader>2 :echo @%<CR>
vnoremap <leader>2 :echo @%<CR>

" Convert slashes to backslashes for Windows.
" http://vim.wikia.com/wiki/VimTip600
nnoremap <leader>cp :let @+=expand("%")<CR>
nnoremap <leader>cl :let @+=expand("%:p")<CR>
" }}}
" functions - TODO - group these {{{
" fun: left/right-strip a string {{{
" https://vi.stackexchange.com/questions/2867/how-do-you-chomp-a-string-in-vim
function! Chomp(string)
    return substitute(a:string, '\n\+$', '', '')
endfunction
function! ChompedSystem( ... )
    return substitute(call('system', a:000), '\n\+$', '', '')
endfunction
" }}}
" fun: Make and jump to temporary files {{{
function! MakeTmpFile()
    let $a = system('mktemp --suffix ".markdown"')
    :tabnew $a
endfunc
nnoremap <leader>mk :call MakeTmpFile()<CR>
" }}}
" fun: Open URLs in your browser {{{
function! HandleURL()
    let s:uri = matchstr(getline("."), '[a-z]*:\/\/[^ >,;]*')
    echo s:uri
    if s:uri != ""
        silent exec "!xdg-open '".s:uri."'"
    else
        echo "No URI found in line."
    endif
endfunction
map <leader>uu :call HandleURL()<CR>
" }}}
" fun: Who did this. {{{
" function! WriteWhoDidThis()
"     let l:name = "Nikos Koukis"
"     let l:curDate = ChompedSystem('date')
"     let l:fullStr = l:curDate . ' - ' . l:name
"     :put=l:fullStr
"     :Commentary " take care of the comment type
" endfunc
" nnoremap <F12> :call WriteWhoDidThis()<CR>
" }}}
" fun: get visual selection - vimscript {{{
function! g:GetVisualSelection()
    " Why is this not a built-in Vim script function?!
    let [line_start, column_start] = getpos("'<")[1:2]
    let [line_end, column_end] = getpos("'>")[1:2]
    let lines = getline(line_start, line_end)
    if len(lines) == 0
        return ''
    endif
    let lines[-1] = lines[-1][: column_end - (&selection == 'inclusive' ? 1 : 2)]
    let lines[0] = lines[0][column_start - 1:]
    return join(lines, "\n")
endfunction
" }}}
" }}}
" Changing the default title - courtesy of http://www.dotfiles.org/~inty/.vimrc {{{
if has('title')
	set titlestring=
	set titlestring+=%f\                     " file name
	set titlestring+=%h%m%r%w                " flags
	set titlestring+=\ -\ %{v:progname}      " program name
	set titlestring+=\ -\ %{substitute(getcwd(),\ $HOME,\ '~',\ '')} " working directory
endif
" }}}
" Sane scrolling {{{
if !&scrolloff
	set scrolloff=1
endif
if !&sidescrolloff
	set sidescrolloff=5
endif
set display+=lastline
" }}}
" Octave/Matlab configuration {{{
augroup filetypedetect " This is a special autocommands group do not do autocmd! by itself!!!
	autocmd! BufRead,BufNewFile *.m,*.oct set filetype=matlab
augroup END

" }}}
" Greek Support  {{{
" courtesy of vkoukis
set langmap=ΑA,ΒB,ΨC,ΔD,ΕE,ΦF,ΓG,ΗH,ΙI,ΞJ,ΚK,ΛL,ΜM,ΝN,ΟO,ΠP,ΡR,ΣS,ΤT,ΘU,ΩV,WW,ΧX,ΥY,ΖZ,αa,βb,ψc,δd,εe,φf,γg,ηh,ιi,ξj,κk,λl,μm,νn,οo,πp,ρr,σs,τt,θu,ωv,ςw,χx,υy,ζz
nmap Θ :redo<CR>

" use CTRL + 6 when in insert mode to switch to the language specified by the
" keymap whenever you get into insert mode automatically
" set keymap=greek_utf-8
set keymap=
set iminsert=0
set imsearch=-1


" arrange lines - up to 80 characters
vnoremap γ; gq
" }}}
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
" Rust configuration {{{
let g:rustfmt_command = 'cargo fmt -- '
" let g:rustfmt_options = '-f'
let g:rustfmt_autosave = 1
let g:rustfmt_fail_silently = 0

" Use rusty-ctags to produce a tags file for vim
autocmd BufRead *.rs :setlocal tags=./rusty-tags.vi;/,$RUST_SRC_PATH/rusty-tags.vi
autocmd BufWritePost *.rs :silent! exec "!rusty-tags vi --quiet --start-dir=" . expand('%:p:h') . "&" | redraw!
" }}}
" Tags configuration {{{
set tags+=./tags;,tags;/
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

" ctags support for rust
let g:tagbar_type_rust = {
   \ 'ctagstype' : 'rust',
   \ 'kinds' : [
       \'T:types,type definitions',
       \'f:functions,function definitions',
       \'g:enum,enumeration names',
       \'s:structure names',
       \'m:modules,module names',
       \'c:consts,static constants',
       \'t:traits',
       \'i:impls,trait implementations',
   \]
   \}

" Open tag in new tab
nnoremap <silent><Leader><C-]> <C-w><C-]><C-w>T

" }}}

" Generate tags
map <leader>rt :!ctags -R --fields=+liaS --tag-relative . <CR>

" g<C-]> will jump to the tag if there's only one match and will present a list
" if there are multiple matches
" https://stackoverflow.com/questions/14465383/how-to-navigate-multiple-ctags-matches-in-vim
nnoremap <C-]> g<C-]>
" }}}
" Plugins configuration {{{
" clang_format {{{
let g:clang_format#command = "/usr/bin/clang-format-3.8"
let g:clang_format#detect_style_file = 1
let g:clang_format#auto_format_on_insert_leave = 0
let g:clang_format#auto_format = 0
let g:clang_format#auto_formatexpr = 0
" }}}
" Tagbar {{{
nnoremap <leader>to :TagbarToggle<CR>
" Start with tagbar disabled, and open tagbar at all the vim buffers afterwards
map <leader>To :tabdo :Tagbar<CR>
map <leader>TO :tabdo :TagbarClose<CR>
" }}}
" Tabularize {{{
nnoremap <leader>bb :Tabularize /
vnoremap <leader>bb :Tabularize /
autocmd VimEnter * AddTabularPattern 1=    /^[^=]*\zs=
autocmd VimEnter * AddTabularPattern 1==   /^[^=]*\zs=/r0c0l0
" }}}
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
let g:airline#extensions#ale#enabled = 0
let g:airline_focuslost_inactive = 1

" " highlight current tab
" hi TabLineFill ctermfg=LightGreen ctermbg=DarkGreen
" hi TabLine ctermfg=Black ctermbg=Green
" hi TabLineSel ctermfg=LightBlue

if !exists('g:airline_symbols')
	let g:airline_symbols = {}
endif
let g:airline_symbols.space = "\ua0"

" }}}
" vim_markdown {{{
let g:vim_markdown_folding_disabled=1
let g:vim_markdown_math=1
let g:vim_markdown_frontmatter=1
" }}}
" Cppman {{{
command! -nargs=+ Cppman silent! call system("tmux split-window cppman " . expand(<q-args>))
" }}}
" Ale - Asynchronous linting/fixing for Vim and Language Server Protocol (LSP) integration  {{{
" https://github.com/w0rp/ale#usage
"
" Run it manually
map <leader>sc :ALELint<CR>
"
" let b:ale_fixers = ['prettier', 'eslint'] # TODO - order by order of run
" let g:ale_fix_on_save = 1
" let g:ale_completion_enabled = 1
let g:ale_sign_column_always = 1
" TODO Test :ALEGoToDefinition
" TODO Test :ALEFindReferences
" TODO Test :ALEHover
" TODO Test :ALESymbolSearch
let g:ale_echo_msg_error_str = 'E'
let g:ale_echo_msg_warning_str = 'W'
let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'

let g:ale_lint_on_text_changed = 'never'
let g:ale_lint_on_save = 1
" You can disable this option too if you don't want linters to run on opening a
" file
" let g:ale_lint_on_enter = 0

" Ale - CPP configuration {{{
" use compile_commands.json
let g:ale_c_parse_compile_commands = 1
let g:ale_c_build_dir_names = ['build', 'build_rel', 'obj']
" let g:ale_c_build_dir = 'build'
" let b:ale_c_parse_makefile = 1

let g:ale_cpp_cppcheck_options='--enable=all --project=./compile_commands.json'
let g:ale_cpp_clang_options='-std=c++14 -Wall -I/usr/include -I/usr/local/include -I/usr/local/include/eigen3'
let g:ale_cpp_gcc_options='-std=c++14 -Wall -I/usr/include/ -I/usr/local/include/ -I/usr/local/include/eigen3'

" }}}

" navigate between errors
nmap <silent> <C-k> <Plug>(ale_previous_wrap)
nmap <silent> <C-j> <Plug>(ale_next_wrap)

" Enable hovering
" Doesn't work in terminal vim
" g:ale_set_balloons = 1
" }}}
" AutoPairs - https://github.com/jiangmiao/auto-pairs {{{
let g:AutoPairsFlyMode = 0
let g:AutoPairsShortcutToggle = '<leader>ap'
" }}}
" jedi-vim {{{
let g:jedi#popup_select_first = 1
let g:jedi#show_call_signatures = "1"
let g:jedi#documentation_command = "K"
if has('nvim')
    let g:python3_host_prog="/usr/bin/python3"
endif
" }}}
" vim-startify {{{
let g:startify_change_to_dir = 0
" }}}
" vim-titlecase {{{
" }}}
" vim-latex configuration {{{
let g:Tex_CompileRule_pdf = 'xelatex $*'
let g:Tex_GotoError = 0
let g:Tex_ShowErrorContext = 0
" }}}
" vim-maximiser {{{
let g:maximizer_set_default_mapping = 1
nnoremap <silent><leader>tz :MaximizerToggle<CR>
vnoremap <silent><leader>tz :MaximizerToggle<CR>gv
inoremap <silent><leader>tz <C-o>:MaximizerToggle<CR>
" }}}
" UltiSnips {{{
" If you want :UltiSnipsEdit to split your window.
let g:UltiSnipsEditSplit="vertical"
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<s-tab>"

" }}}
" bullets.vim - Markdown plugin for correct indentation of bullet lists {{{
" https://github.com/dkarter/bullets.vi://github.com/dkarter/bullets.vim
" Use C-d/C-t for indenting outwards/inwards
" In visual: :RenumberSelection
" }}}
" vim-autoformat {{{
" https://github.com/Chiel92/vim-autoformat
noremap <leader>af :Autoformat<CR>
let g:formatter_yapf_style = 'pep8'
" }}}
" vimproc.vim {{{
" You need to run **make** prior to running this
" https://github.com/Shougo/vimproc.vim.git ~/.vim/bundle/vimproc.vim
" }}}
" vim2hs - Haskell multipurpose plugin {{{
" https://github.com/dag/vim2hs
let g:haskell_conceal_wide = 1
let g:haskell_tabular = 1
" }}}
" indentLine {{{
let g:indentLine_enabled = 1
"
" }}}
" Terminus {{{
" Adding minor important capabilities to vim (mouse support, terminal-agnostic
" mouse cursor)
"
" https://github.com/wincent/terminus
"
" let g:TerminusNormalCursorShape=1
"
" }}}
" commentary.vim {{{
" https://github.com/tpope/vim-commentary
" }}}
" vim-eunoch {{{
" helpers for UNIX
" https://github.com/t<F20>pope/vim-eunuch
" }}}
" undotree - like GUndo {{{
nnoremap <leader>ut :UndotreeToggle<CR>
" }}}
" vim-tmux-navigator {{{
" Disable tmux navigator when zooming the Vim pane
let g:tmux_navigator_disable_when_zoomed = 1
let g:tmux_navigator_save_on_switch = 1
" }}}
" vim-signature - Wow, so useful of a plugin{{{
" https://github.com/kshenoy/vim-signature
"
let g:SignatureMarkTextHLDynamic=1
" }}}
" vim-projectionist {{{
nnoremap <leader>zz :A<CR>
nnoremap <leader>zv :AV<CR>
nnoremap <leader>zs :AS<CR>
nnoremap <leader>zt :AT<CR>
" }}}
" vim-dispatch {{{
nnoremap <Leader>m :Make -C build <CR>
nnoremap <Leader><Leader>m :Make! -C build <CR>
" }}}
" vim-fugitive {{{
" Show the glog results in the quickfix window by :copen after glog
" }}}
" vim-matchup {{{

let g:matchup_transmute_enabled = 1
let g:matchup_matchparen_status_offscreen = 0
let g:matchup_delim_stopline = 1500 " generally
let g:matchup_matchparen_stopline = 200  " for match highlighting only
hi MatchParen cterm=none ctermbg=none ctermfg=magenta
" }}}
" vim-scriptease - Scripts/Utilities for vim plugin development {{{
" https://github.com/tpope/vim-scriptease
"
" use :Scriptnames instead of :scriptnames
" }}}
" cppman configuration {{{

" }}}
" vim-debugstring {{{
"
" }}}
" deoplete.nvim {{{

" Use deoplete.
let g:deoplete#enable_at_startup = 1
let g:deoplete#enable_smart_case = 1

" if !exists('g:deoplete#omni#input_patterns')
"     let g:deoplete#omni#input_patterns = {}
" endif

" Disable the candidates in String syntaxes.
call deoplete#custom#source('_',
            \ 'disabled_syntaxes', ['String'])

autocmd InsertLeave,CompleteDone * if pumvisible() == 0 | pclose | endif

let g:deoplete#sources#jedi#extra_path = '$HOME/.local/lib/python3.5/site-packages/'
let g:res = ""
if has('python3')
    let g:res = ChompedSystem('python3 -m site --user-site')
elseif has('python2')
    let g:res = ChompedSystem('python2 -m site --user-site')
end
let g:deoplete#sources#jedi#extra_path = [g:res]
let g:deoplete#sources#jedi#show_docstring = 1
let g:deoplete#sources#jedi#enable_cache = 1

" }}}
" deoplete-rust {{{

let g:deoplete#sources#rust#racer_binary=$HOME . '/.cargo/bin/racer'
let g:deoplete#sources#rust#show_duplicates=0
let g:deoplete#sources#rust#documentation_max_height=20
let g:deoplete#sources#rust#rust_source_path=$RUST_SRC_PATH

" }}}
" deoplete-clang {{{
let g:deoplete#sources#clang#libclang_path='/usr/lib/libclang.so'
let g:deoplete#sources#clang#clang_header='/usr/lib/clang'
let g:deoplete#sources#clang#std={'c': 'c11', 'cpp': 'c++1z', 'objc': 'c11', 'objcpp': 'c++1z'}
let g:deoplete#sources#clang#clang_complete_database='.'
" }}}
" neoinclude {{{
if !exists('g:neoinclude#exts')
	let g:neoinclude#exts = {}
endif
let g:neoinclude#exts.cpp = ['', 'h', 'hpp', 'hxx']
" }}}
" vim-markdown {{{

let g:vim_markdown_conceal = 0

" }}}
" nvim-chromatica {{{

nnoremap <leader>cs :ChromaticaStart<CR>
nnoremap <leader>cS :ChromaticaStop<CR>
let g:chromatica#libclang_path='/usr/lib/libclang.so'
let g:chromatica#enable_at_startup=1
let g:chromatica#highlight_feature_level=1
" let g:chromatica#responsive_mode=1
" }}}
" i3-vim-focus {{{
" TODO - fix it

map gwl :call Focus('right', 'l')<CR>
map gwh :call Focus('left', 'h')<CR>
map gwk :call Focus('up', 'k')<CR>
map gwj :call Focus('down', 'j')<CR>

" }}}
" undoquit {{{
let g:undoquit_mapping = '<Leader>uq'
" }}}
" vim-sourcetrail {{{

nnoremap <leader>l :SourcetrailActivateToken<CR>

" }}}
" vimwiki {{{
nmap <Leader>vw <Plug>VimwikiIndex

let g:vimwiki_list = [{'path': '~/MEGA/vimwiki',
            \ 'auto_tags': 1,
            \ 'auto_diary_index': 1}]
let g:vimwiki_folding=''
let g:vimwiki_hl_headers = 1
let g:vimwiki_use_mouse = 1
let g:vimwiki_auto_header = 1
let g:links_space_char = '_'

" }}}
" vim-taskwarrior plugin configuration - Needed by taskwiki {{{
" https://github.com/blindFS/vim-taskwarrior
let g:task_rc_override = 'rc.defaultwidth=0' " line-wrapping
" }}}
" taskwiki {{{
let g:work_str = $WORK
let g:taskwiki_sort_order="status+,pri+,end+,due+,pri-,project+"

" MakeDiarySections function - use taskwiki viewports {{{
function! MakeDiarySections()
    let l:date_str = strftime('%Y-%m-%d')
    let l:header = "= " . l:date_str . " ="
    put!=l:header

    let l:home = "== " . "home | project:home due:" . l:date_str . " =="
    put=l:home
    " Make it more generic, perhaps have the caller give you these strings
    let l:work = "== " . "work | project:" . g:work_str . " due:" . l:date_str . " =="
    put=l:work

    let l:rest = "== " . "rest |" . " project: due:" . l:date_str . " =="
    put=l:rest
endfunc

function! PopulateWeeklyDone()
    let l:date_str = strftime('%Y-%m-%d')
    let l:header = "= Work until " . l:date_str . " | project:" . g:work_str .
                \ " end.after:today-1wk status:completed " .  "="
    put!=l:header

    let l:refined_str = "Refined List"
    put!=l:refined_str
endfunc
" }}}
" }}}
" fzf - fuzzy-finder {{{
" https://github.com/junegunn/fzf
" https://github.com/junegunn/fzf.vim
"
set rtp+=$HOME/.linuxbrew/opt/fzf

let g:fzf_action = {
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-x': 'split',
  \ 'ctrl-v': 'vsplit' }

let g:fzf_colors =
\ { 'fg':      ['fg', 'Normal'],
  \ 'bg':      ['bg', 'Normal'],
  \ 'hl':      ['fg', 'Comment'],
  \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
  \ 'hl+':     ['fg', 'Statement'],
  \ 'info':    ['fg', 'PreProc'],
  \ 'border':  ['fg', 'Ignore'],
  \ 'prompt':  ['fg', 'Conditional'],
  \ 'pointer': ['fg', 'Exception'],
  \ 'marker':  ['fg', 'Keyword'],
  \ 'spinner': ['fg', 'Label'],
  \ 'header':  ['fg', 'Comment'] }
nnoremap <leader>tf :Files<CR>
nnoremap <leader>tF :Files 
nnoremap <leader>tt :Tags<CR>
nnoremap <leader>tb :Buffers<CR>
nnoremap <leader>tw :Windows<CR>

" Mapping selecting mappings
nmap <leader><tab> <plug>(fzf-maps-n)
xmap <leader><tab> <plug>(fzf-maps-x)
omap <leader><tab> <plug>(fzf-maps-o)

" Insert mode completion
imap <c-x><c-k> <plug>(fzf-complete-word)
imap <c-x><c-f> <plug>(fzf-complete-path)
imap <c-x><c-j> <plug>(fzf-complete-file-ag)
imap <c-x><c-l> <plug>(fzf-complete-line)

nnoremap q: :History:<CR>
nnoremap q/ :History/<CR>

" Files [PATH] 	Files (similar to :FZF)
" GFiles [OPTS] 	Git files (git ls-files)
" GFiles? 	Git files (git status)
" Buffers 	Open buffers
" Colors 	Color schemes
" Ag [PATTERN] 	ag search result (ALT-A to select all, ALT-D to deselect all)
" Rg [PATTERN] 	rg search result (ALT-A to select all, ALT-D to deselect all)
" Lines [QUERY] 	Lines in loaded buffers
" BLines [QUERY] 	Lines in the current buffer
" Tags [QUERY] 	Tags in the project (ctags -R)
" BTags [QUERY] 	Tags in the current buffer
" Marks 	Marks
" Windows 	Windows
" Locate PATTERN 	locate command output
" History 	v:oldfiles and open buffers
" History: 	Command history
" History/ 	Search history
" Snippets 	Snippets (UltiSnips)
" Commits 	Git commits (requires fugitive.vim)
" BCommits 	Git commits for the current buffer
" Commands 	Commands
" Maps 	Normal mode mappings
" Helptags 	Help tags 1
" Filetypes 	File types

" }}}
" }}}
" Vim-path and path-aware commands configuration {{{
set path+=/usr/local/include,**
" }}}
" Abbreviations - vim {{{
ab wrt with regards to
ab wRt with respect to
ab teh the
" }}}
" machine-local configuration {{{
let g:local_vimrc = '~/.vimrc.local'
execute 'source ' . g:local_vimrc
" }}}
