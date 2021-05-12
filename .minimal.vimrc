" ------------------------------------------------------------------------------
"
"  Basic no-plugins version of .vimrc that you can freely copy to other
"  workstations that you want to use vim on.
"
" ------------------------------------------------------------------------------
"
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
" will fail if not Neovim
silent! set inccommand=split
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

"" g<C-]> will jump to the tag if there's only one match and will present a list
" if there are multiple matches
" https://stackoverflow.com/questions/14465383/how-to-navigate-multiple-ctags-matches-in-vim
nnoremap <C-]> g<C-]>
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
