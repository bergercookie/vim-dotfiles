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
set nowritebackup
set noswapfile
set signcolumn="yes"
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
" Remap <leader> to comma {{{
let mapleader = ","
nnoremap \ ,
" }}}
" Searching Configuration {{{
set ignorecase
set smartcase
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
" undo directory setup {{{
let undo_dir_path = $HOME . "/.cache/vim-undo-dir"
if !isdirectory(undo_dir_path)
    call system("mkdir -p " . undo_dir_path)
    call system("chmod " . "700 " .  undo_dir_path)
endif
let &undodir = undo_dir_path
set undofile
" }}}


" }}}

" do it only when you have a good reason to.
set listchars=eol:¬,tab:>·,trail:~,extends:>,precedes:<
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
" Vim-plug package manager {{{

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

" Enabled Plugins {{{
call plug#begin()
Plug 'junegunn/vim-plug'
Plug 'https://github.com/tpope/vim-surround'
" automatically change the ending (or starting) HTML tag when the starting (or
" ending HTML tag is modified)
Plug 'https://github.com/AndrewRadev/tagalong.vim'
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
Plug 'https://github.com/sudar/vim-arduino-snippets'
Plug 'https://github.com/rust-lang/rust.vim'
Plug 'https://github.com/nickhutchinson/vim-cmake-syntax'
Plug 'https://github.com/plasticboy/vim-markdown'
Plug 'https://github.com/dkarter/bullets.vim', {'for': ['markdown', 'rst', 'vimwiki']}
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
Plug 'https://github.com/Yggdroot/indentLine'
Plug 'https://github.com/google/vimdoc'
Plug 'https://github.com/junegunn/vader.vim'
Plug 'https://github.com/janko-m/vim-test'
Plug 'https://github.com/andymass/vim-matchup'
Plug 'https://github.com/vim-utils/vim-man', {'tag': 'v0.1.0'}
Plug 'https://github.com/racer-rust/vim-racer'
Plug 'https://github.com/tpope/vim-liquid'
Plug 'arcticicestudio/nord-vim'
Plug 'https://github.com/tpope/vim-rsi'
" For :GBrowse
Plug 'https://github.com/tommcdo/vim-fubitive'
Plug 'https://github.com/tpope/vim-rhubarb'
" Multi-entry selection UI. FZF
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'https://github.com/jwilm/i3-vim-focus'
Plug 'https://github.com/NLKNguyen/papercolor-theme'
Plug 'https://github.com/christoomey/vim-titlecase'
Plug 'https://github.com/bronson/vim-visual-star-search'
Plug 'https://github.com/kmarius/vim-fish'
Plug 'https://github.com/cespare/vim-toml'
Plug 'https://github.com/lambdalisue/suda.vim'
Plug 'https://github.com/embear/vim-localvimrc'
Plug 'https://github.com/jez/vim-superman'
Plug 'https://github.com/beyondmarc/opengl.vim'
Plug 'https://github.com/tikhomirov/vim-glsl'
Plug 'https://github.com/peterhoeg/vim-qml'
Plug 'https://github.com/farfanoide/vim-kivy'
Plug 'https://github.com/chrisbra/Colorizer'
Plug 'https://github.com/sheerun/vim-polyglot'
Plug 'https://github.com/CoatiSoftware/vim-sourcetrail'
" Plug 'https://github.com/johnsyweb/vim-makeshift'
" ranger.vim
Plug 'rbgrouleff/bclose.vim'
Plug 'https://github.com/francoiscabrol/ranger.vim'
Plug 'chriskempson/base16-vim'
Plug 'https://github.com/jamessan/vim-gnupg/'
" Or build from source code by using yarn: https://yarnpkg.com
Plug 'neoclide/coc.nvim', {'do': 'yarn install --frozen-lockfile'}
Plug 'jackguo380/vim-lsp-cxx-highlight'
Plug 'https://github.com/bfrg/vim-cpp-modern'
Plug 'https://github.com/sukima/xmledit'
Plug 'https://github.com/junegunn/goyo.vim'
Plug 'mattn/emmet-vim'
Plug 'https://github.com/SirVer/ultisnips'
" real-plug-end


" vimwiki, taskwiki + dependencies
Plug 'https://github.com/vimwiki/vimwiki', { 'branch': 'dev' }
Plug 'https://github.com/tbabej/taskwiki'
Plug 'https://github.com/farseer90718/vim-taskwarrior',  { 'on': 'VimwikiIndex' }

" text objects general configuration {{{
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
" own + maintained versions {{{
Plug 'ssh://git@github.com/bergercookie/vim-snippets'
Plug 'ssh://git@github.com/bergercookie/vimduino-cli'
Plug 'ssh://git@github.com/bergercookie/vim-debugstring'
Plug 'https://github.com/bergercookie/vim-log-syntax'
Plug 'https://github.com/bergercookie/vim-deb-preview'
" Plug 'ssh://git@github.com:bergercookie/vim-britishise'
" Plug 'ssh://git@github.com:bergercookie/describe.nvim', {'do': 'UpdateRemotePlugins'}
" }}}
" }}}

" Automatically executes filetype plugin indent on and syntax enable. You can
" revert the settings after the call. e.g. filetype indent off, syntax off, etc
call plug#end()
" }}}
" Colorscheme Configuration {{{
" See :Colors<CR> for previewing another colorscheme
set background=dark
set t_Co=256
set termguicolors
colorscheme base16-atelier-forest
let g:PaperColor_Theme_Options = {
  \   'theme': {
  \     'default.dark': {
  \       'transparent_background': 1
  \     }
  \   }
  \ }

function! ChangeLineColor()
    highlight CursorLine guibg=#2c2460
endfunction
function! ChangeLineColor2()
    highlight CursorLine guibg=#2c2421
endfunction
command! -bang CLC call ChangeLineColor()
command! -bang CLCC call ChangeLineColor2()

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
nnoremap <leader>2   :echo @%<CR>
vnoremap <leader>2   :echo @%<CR>
nnoremap <leader>22  :let @+=expand("%")<CR>
vnoremap <leader>22  :let @+=expand("%")<CR>

" Convert slashes to backslashes for Windows.
" http://vim.wikia.com/wiki/VimTip600
nnoremap <leader>cp :let @+=expand("%")<CR>
nnoremap <leader>cl :let @+=expand("%:p")<CR>
nnoremap <leader>fl :call FillLine('-')<CR>
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
" Fill the rest of a line with characters {{{
function! FillLine(str)
    " set tw to the desired total length
    let tw = &textwidth
    if tw==0 | let tw = 80 | endif
    " strip trailing spaces first
    .s/[[:space:]]*$//
    " calculate total number of 'str's to insert
    let reps = (tw - col("$")) / len(a:str)
    " insert them, if there's room, removing trailing spaces (though forcing
    " there to be one)
    if reps > 0
        .s/$/\=(' '.repeat(a:str, reps))/
    endif
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
" Remove Trailing Whitespaces - https://vim.fandom.com/wiki/Remove_unwanted_spaces {{{
function StripTrailingWhitespace()
  if !&binary && &filetype != 'diff'
    normal mz
    normal Hmy
    %s/\s\+$//e
    normal 'yz<CR>
    normal `z
  endif
endfunction
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

function! s:open_vim_snippets()
    if empty(&filetype)
        echoerr "No filetype selected"
    else
        execute "tabnew $HOME" . "/.vim/plugged/vim-snippets/snippets/" . &filetype . ".snippets"
    end
endfunction
command! OpenVimSnippets call s:open_vim_snippets()

" }}}
" Rust configuration {{{
let g:rustfmt_command = 'cargo +nightly fmt -- '
" let g:rustfmt_options = '-f'
let g:rustfmt_autosave = 0
let g:rustfmt_fail_silently = 0

" Use rusty-ctags to produce a tags file for vim
autocmd BufRead *.rs :setlocal tags=./rusty-tags.vi;/,$RUST_SRC_PATH/rusty-tags.vi
autocmd BufWritePost *.rs :silent! exec "!rusty-tags vi --quiet --start-dir=" . expand('%:p:h') . "&" | redraw!
" }}}
" Tags configuration {{{
set tags+=./tags;,tags;/
" ctags configuration {{{

" ctags support for XML
let g:tagbar_type_xml = {
	\ 'ctagstype' : 'XML',
	\ 'kinds' : [
		\ 't:tagname'
	\ ],
	\ 'sort' : 0
\ }

" ctags support for Launchfiles
let g:tagbar_type_launch = {
	\ 'ctagstype' : 'Launch',
	\ 'kinds' : [
		\ 'n:name'
	\ ],
	\ 'sort' : 0
\ }


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
map <leader>rt :Dispatch ctags -R --fields=+liaS --tag-relative . <CR>

" g<C-]> will jump to the tag if there's only one match and will present a list
" if there are multiple matches
" https://stackoverflow.com/questions/14465383/how-to-navigate-multiple-ctags-matches-in-vim
nnoremap <C-]> g<C-]>
" }}}
" Plugins configuration {{{
" tagalong.vim {{{
" BUG: Doesn't update open tag when modifying closing one?
let g:tagalong_filetypes = ['html', 'xml', 'jsx', 'eruby', 'ejs', 'eco', 'php', 'htmldjango', 'javascriptreact', 'typescriptreact']
let g:tagalong_verbose = 1
"}}}
" surround.vim {{{
"
" FOR HTML
"
" To wrap the word with an HTML div tag, place your cursor over the word and
" type ysiw<div id="some-id-to-be-added-to-the-starting-div-only"<CR>
"
" To change an existing HTML tag (to div):
" type csttdiv id="..."<CR>
"
" }}}
" emmet-vim {{{
" Use C-y, to expand
let g:user_emmet_install_global = 1
" }}}
" xml-edit {{{
let g:xml_syntax_folding=1
au FileType xml setlocal foldmethod=syntax"
" }}}
" ranger.vim {{{
" open ranger when vim open a directory
let g:ranger_replace_netrw = 0
" }}}
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
let g:airline_theme="base16_atelierforest"
let g:airline_highlighting_cache = 0
let g:airline_focuslost_inactive = 1
let g:airline#extensions#coc#enabled = 1
let g:airline#extensions#tabline#formatter = 'unique_tail_improved'

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
" AutoPairs - https://github.com/jiangmiao/auto-pairs {{{
let g:AutoPairs =  {'(':')', '[':']', '{':'}', "'":"'", '"':'"', '"""':'"""', "'''":"'''"}
let g:AutoPairsFlyMode = 0
let g:AutoPairsShortcutToggle = '<leader>ap'

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
autocmd FileType asm setlocal commentstring=;\ %s
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
" vim-deb-preview {{{
let g:debpreview_overwrite = 1
let g:debpreview_newdebfile_ext =".new"
" }}}
" vim-markdown {{{

let g:vim_markdown_conceal = 0

" }}}
" vim-racer {{{
let g:racer_cmd = $HOME . '/.cargo/bin/racer'
let g:racer_experimental_completer = 1
let g:racer_insert_paren = 1
let g:racer_disable_errors = 0
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

let g:vimwiki_list = [
            \ {'path': '$HOME/sync/main/vimwiki',
            \  'auto_tags': 1,
            \  'auto_diary_index': 1},
            \ {'path': '$HOME/Documents/bergercookie.github.io/_posts',
            \  'auto_tags': 1,
            \  'auto_diary_index': 1,
            \  'syntax': 'markdown', 'ext': '.md' },
            \ {'path': '$HOME/sync/bulk/evernote-wiki',
            \  'auto_tags': 1,
            \  'auto_diary_index': 1,
            \  'syntax': 'markdown', 'ext': '.md' }]
let g:vimwiki_folding=''
let g:vimwiki_hl_headers = 1
let g:vimwiki_use_mouse = 1
let g:vimwiki_auto_header = 1
let g:links_space_char = '_'
let g:vimwiki_home='$HOME/sync/main/vimwiki'
let g:vimwiki_global_ext=0
command! -bang VimWikiFiles call fzf#run(fzf#wrap({ 'source': 'fd . $HOME/sync/main/vimwiki $HOME/Documents/bergercookie.github.io/_posts $HOME/sync/bulk/evernote-wiki' }, <bang>0))
nnoremap <leader>vf :VimWikiFiles<CR>

command! -bang -nargs=* VimWikiSearch
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --color=always --smart-case ' . shellescape(<q-args>) . ' $HOME/sync/main/vimwiki $HOME/Documents/bergercookie.github.io/_posts $HOME/sync/bulk/evernote-wiki', 1,
  \   <bang>0 ? fzf#vim#with_preview('up:60%')
  \           : fzf#vim#with_preview('right:50%:hidden', '?'),
  \   <bang>0)
nnoremap <leader>vs :VimWikiSearch<CR>

" }}}
" vim-taskwarrior plugin configuration - Needed by taskwiki {{{
" https://github.com/blindFS/vim-taskwarrior
let g:task_rc_override = 'rc.defaultwidth=0' " line-wrapping
" }}}
" taskwiki {{{
let g:work_str = $WORK
let g:taskwiki_sort_order="status+,pri+,end+,due+,pri-,project+"

" }}}
" }}}
" Fzf - fuzzy-finder {{{
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

" Search with ripgrep in a custom directory
command! -bang -nargs=* Rgg
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --color=always --smart-case ' . split(<q-args>, ' ')[0] . ' ' . split(<q-args>, ' ')[1], 1,
  \   <bang>0 ? fzf#vim#with_preview('up:60%')
  \           : fzf#vim#with_preview('right:50%:hidden', '?'),
  \   <bang>0)

nnoremap <leader>tt :Tags<CR>
vnoremap <leader>tt :call fzf#vim#tags(GetVisualSelection())<CR>

nnoremap <leader>tb :Buffers<CR>
nnoremap <leader>tw :Windows<CR>
nnoremap <leader>th :History<CR>
nnoremap <leader>t/ :History/<CR>
nnoremap <leader>t: :History:<CR>

" sacriligeous?
nmap - :Windows<CR>

" Mapping selecting mappings
nmap <leader><tab> <plug>(fzf-maps-n)
xmap <leader><tab> <plug>(fzf-maps-x)
omap <leader><tab> <plug>(fzf-maps-o)

" Insert mode completion
imap <c-x><c-k> <plug>(fzf-complete-word)
imap <c-x><c-f> <plug>(fzf-complete-path)
imap <c-x><c-j> <plug>(fzf-complete-file-ag)
imap <c-x><c-l> <plug>(fzf-complete-line)

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
" Edit tldr files {{{
" to expand do not use `<space>` but use `/` instead!
cabbr tldrl tabnew ~/.cache/albert/tldr_pages/tldr/pages/linux
cabbr tldrc tabnew ~/.cache/albert/tldr_pages/tldr/pages/common
" }}}
" Localvimrc {{{
let g:localvimrc_persistent = 2
let g:localvimrc_sandbox = 0
" }}}
" Vim-path and path-aware commands configuration {{{
set path+=/usr/local/include,**
" }}}
" Abbreviations - vim {{{
ab wrt with regards to
ab wRt with respect to
ab teh the
ab Javascript JavaScript
ab Youtube YouTube
" }}}
" Machine-local configuration {{{
let g:local_vimrc = '~/.vimrc.local'
execute 'source ' . g:local_vimrc
" }}}
" support/config for the fish shell {{{
if &shell =~# 'fish$'
    set shell=sh
endif
" }}}
" Use rg if it's installed {{{
if executable('rg')
    " https://vi.stackexchange.com/a/8858/6972
    set grepprg=rg\ --vimgrep
    set grepformat=%f:%l:%c:%m
endif
" }}}
" coc {{{
" coc.nvim configuration and modules {{{
" These are node modules and are managed by coc itself instead of vim-plug
" see ~/.config/nvim/coc-settings.json file for the coc preferences
"
" Available CoC vim configuration:
"
"   https://github.com/neoclide/coc.nvim#example-vim-configuration
"
" For coc-browser:
"
"   Install browser extension first
"   https://github.com/voldikss/browser-source-provider
"
" Instructions for debugging/tweaking tsserver:
"
"   https://github.com/neoclide/coc-tsserver
"
let g:coc_global_extensions = [
            \ "coc-docker",
            \ "coc-yaml",
            \ "coc-cmake",
            \ "coc-tsserver",
            \ "coc-browser",
            \ "coc-snippets",
            \ "coc-pyright",
            \ "coc-html",
            \ "coc-json",
            \ "coc-css",
            \ "coc-angular",
            \ "coc-deno",
            \ "coc-prettier",
            \ "coc-eslint",
            \ "coc-styled-components",
            \ "coc-react-refactor",
            \ "coc-java",
            \ "coc-markdownlint",
            \ "coc-rust-analyzer",
            \ "coc-marketplace",
            \ "coc-emoji",
            \ "coc-sh",
            \ "coc-xml"
            \]
autocmd FileType json syntax match Comment +\/\/.\+$+
"}}}
" coc-deno {{{
" Use the following two commands on new projects
"
"   deno.cache: Cache Dependencies
"   deno.initializeWorkspace: Initialize workspace configuration for Deno
"
" Also useful:
"
"   deno.status: Display language server status
" }}}
" coc-pyright {{{
" }}}
" Navigate diagnostics {{{
" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)
" }}}
" Go to code navigation {{{
nmap <silent><nowait> gA :<C-u>CocAction<cr>
vmap <silent><nowait> gA :<C-u>CocAction<cr>
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent><nowait> gI :<C-u>CocList -I symbols<cr>
" }}}
" Use K to show documentation in preview window {{{
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" }}}
" coc - various settings {{{
" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code.
xmap <leader>Af  <Plug>(coc-format-selected)
nmap <leader>Af  <Plug>(coc-format-selected)

xmap <leader>af :call CocAction('format')<CR>
nmap <leader>af :call CocAction('format')<CR>

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
xmap <leader>x  <Plug>(coc-codeaction-selected)
nmap <leader>x  <Plug>(coc-codeaction-selected)

" Remap keys for applying codeAction to the current buffer.
nmap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)

" Map function and class text objects
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Mappings for CoCList {{{
" Show all diagnostics.
nnoremap <silent><nowait> <leader>od  :<C-u>CocList diagnostics<cr>
" Show commands.
nnoremap <silent><nowait> <leader>oc  :<C-u>CocList commands<cr>
" Find symbol of current document.
nnoremap <silent><nowait> <leader>oo  :<C-u>CocList outline<cr>
" Search workspace symbols.
nnoremap <silent><nowait> <leader>os  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent><nowait> <leader>on  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent><nowait> <leader>op  :<C-u>CocPrev<CR>
" Resume latest coc list.
nnoremap <silent><nowait> <leader>or  :<C-u>CocListResume<CR>

" Use <C-l> for trigger snippet expand - TAB doesn't seem to work
imap <C-l> <Plug>(coc-snippets-expand)
" }}}

" Use TAB for select text for visual placeholder of snippet.
vmap <tab> <Plug>(coc-snippets-select)
let g:coc_snippet_next = '<tab>'
let g:coc_snippet_prev = '<S-Tab>'
" }}}
" }}}
" for some reason it gets disabled, after a recent PlugUpdate of mine.
" Maybe vim-fish has something to do with it..
syntax on
