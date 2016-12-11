set number
" set mouse=in
let mapleader = ","
let g:mapleader = ","

nmap <leader>w :w!<cr>
" SO - Scroll Offset tries to keep the cursor X lines from the
" bottom of the screen
set so=5

" Turn on the wild menu for command-line completion
set wildmenu

set ignorecase
set smartcase

syntax enable
set nobackup

set smarttab

" Tab conf
set shiftwidth=4
set tabstop=4

set autoindent
set wrap

" Window movement
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-h> <C-w>h
map <C-l> <C-w>l

" Statusline stoof
set laststatus=2
set statusline=%F				      " Truncated path
set statusline+=\ %y			    " Display filetype
set statusline+=%=				    " Switch to right side
set statusline+=Line:\ 			  " Separator
set statusline+=%4l/%-4L		  " Display line/LINES
set statusline+=Col:\ 			  " Separator
set statusline+=%3c\ -\ %-4v	" Display col - vcol
