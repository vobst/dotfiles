" not vi compatible
set nocompatible

let mapleader=","

"------------------
" Syntax and indent
"------------------
" Turn on syntax highlighting.
syntax on

" show matching braces when text indicator is over them
set showmatch 

" highlight current line, but only in active window
augroup CursorLineOnlyInActiveWindow
    autocmd!
    autocmd VimEnter,WinEnter,BufWinEnter * setlocal cursorline
    autocmd WinLeave * setlocal nocursorline
augroup END

" Indent text
set shiftwidth=2
set autoindent

"---------------------
" Basic editing config
"---------------------
" Disable the default Vim startup message.
set shortmess+=I

" visual autocomplete for command menu
set wildmenu   

" Ignore files for completion
set wildignore+=*/.git/*,*/tmp/*,*.swp

" Maintain undo history between sessions
set undofile 
set undodir=~/.vim/undodir

" Show line numbers.
set number

" This enables relative line numbering mode
set relativenumber

" fix slow O inserts
set timeout timeoutlen=1000 ttimeoutlen=100 

" incremental search (as string is being typed)
set incsearch 

" highlight search
set hls 

" more history
set history=8192 

" Always show the status line at the bottom, even if you only have one window open.
set laststatus=2

" backspace over anything.
set backspace=indent,eol,start

" allow auto-hiding of edited buffers
set hidden

" This setting makes search case-insensitive when all characters in the string
" being searched are lowercase. However, the search becomes case-sensitive if
" it contains any capital letters. This makes searching more convenient.
set ignorecase
set smartcase

" Enable searching as you type
set incsearch

" Enable spell checking
map <Leader>d :setlocal spell spelllang=de <return>
map <Leader>e :setlocal spell spelllang=en_us <return>
map <Leader>dd :setlocal nospell spelllang=de <return>
map <Leader>ee :setlocal nospell spelllang=en_us <return>
hi clear SpellBad
hi clear SpellCap
hi clear SpellRare
hi clear SpellLocal
hi SpellBad cterm=underline ctermfg=red
hi SpellCap cterm=underline ctermfg=blue
hi SpellRare cterm=underline ctermfg=green
hi SpellLocal cterm=underline ctermfg=darkcyan

"--------------------
" Misc configurations
"--------------------
" open new split panes to right and bottom, which feels more natural
set splitbelow
set splitright

" quicker window movement
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l

" Unbind some useless/annoying default key bindings.
nmap Q <Nop> 

" Unbind for tmux
map <C-a> <Nop>
map <C-x> <Nop>

" Disable audible bell because it's annoying.
set noerrorbells visualbell t_vb=

" Enable mouse support. You should avoid relying on this too much, but it can
" sometimes be convenient.
set mouse+=a

" locally (window) cd into directory of open buffer
nnoremap <leader>cd :lcd %:p:h<CR>

" Try to prevent bad habits like using the arrow keys for movement. This is
" not the only possible bad habit. For example, holding down the h/j/k/l keys
" for movement, rather than using more efficient movement commands, is also a
" bad habit. The former is enforceable through a .vimrc, while we don't know
" how to prevent the latter.
" Do this in normal mode...
nnoremap <Left>  :echoe "Use h"<CR>
nnoremap <Right> :echoe "Use l"<CR>
nnoremap <Up>    :echoe "Use k"<CR>
nnoremap <Down>  :echoe "Use j"<CR>
" ...and in insert mode
inoremap <Left>  <ESC>:echoe "Use h"<CR>
inoremap <Right> <ESC>:echoe "Use l"<CR>
inoremap <Up>    <ESC>:echoe "Use k"<CR>
inoremap <Down>  <ESC>:echoe "Use j"<CR>

" Max linelength
set colorcolumn=73
highlight OverLength ctermbg=red ctermfg=white guibg=#592929
match OverLength /\%73v.\+/

" Trailing whitespace
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/

"---------------------
" Plugin setup
"---------------------
" automated installation of vim-plug on new system
let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin()
" https://github.com/iamcco/markdown-preview.nvim
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']}

call plug#end()

"---------------------
" Plugin configuration
"---------------------
" load filetype-specific indent files
filetype indent on      

" load filetype specific plugin files
filetype plugin on      

" Configuration of CtrlP plugin (fuzzy finder)
" Keyboard
let g:ctrlp_map = '<c-p>'
" Command line
let g:ctrlp_cmd = 'CtrlP'
" Set working directory to closest with .git file or directory of file (if pwd is not ancestor)
let g:ctrlp_working_path_mode = 'ra'
" Open a new window for already open buffers
let g:ctrlp_switch_buffer = 'et'

" Configuration of CtrlP plugin (fuzzy finder)
" set to 1, the nvim will auto close current preview window when change
" " from markdown buffer to another buffer
let g:mkdp_auto_close = 0
let g:mkdp_browser = '/usr/bin/chromium'



"---------------------
" Local customizations
"---------------------

" local customizations in ~/.vimrc_local
let $LOCALFILE=expand("~/.vimrc_local")
if filereadable($LOCALFILE)
    source $LOCALFILE
endif
