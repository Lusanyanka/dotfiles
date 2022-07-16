" Sauce me those sweet, sweet line numbers
set number
" Enable mouse control in normal and visual modes
set mouse=nv
set nocompatible
filetype plugin on
runtime! ftplugin/man.vim

" Attempt to remove a comment leader when joining lines
set formatoptions+=j

" Map space as leader
nnoremap <SPACE> <Nop>
let mapleader = " "
let g:mapleader = " "

" Set tags to search current dir for tags, all the way up to $HOME
set tags=./tags,tags;$HOME

" Sudo trick to write out a file as superuser -- very useful if you forget to
" open a file as su.
"
" Uses tee as sudo to write out the contents of the current buffer to the name
" of the file that's currently open [%].
cmap w!! w !sudo tee >/dev/null %

"
" Silly leader shortcuts
"
nmap <leader>w :w!<cr>
nmap <leader>q :q<cr>
" Reload vimrc
nmap <leader>r :source ~/.vimrc<cr>
" Substitute through the whole buffer
nmap <leader>s :%s/
" Toggle fold open/closed
nmap <leader>z za
" Use register c ["c] to yank the word under the cursor [yiw] and start a
" substitution in the current buffer [:%s/] with the word in register c 
" [<C-r>c].
nmap <leader>h "cyiw:%s/\<<C-r>c\>/
set so=10

" ColorColumn - very useful for keeping kernel code within 80-chars wide
set cc=80
" Change the colour of the ColourColumn and Folds to be light black. Requires
" at least a 16-colour terminal.  Check the TERM environment variable if
" ColorColumn and Folds are invisible
highlight ColorColumn ctermbg=8
highlight Folded      ctermbg=8 ctermfg=3
" disable search highlighting with escape
nnoremap <silent> <esc> :noh<cr><esc>

" Turn on command-line completion
set wildmenu

set ignorecase
set smartcase

" Pretty colours pls
syntax enable
"
" Uncomment to disable search highlighting
" set nohlsearch

" Enforce standard no-backup setting
set nobackup

" Tab conf
set shiftwidth=8
set tabstop=8
" Enforce default use of \t characters instead of spacing
set noexpandtab

" Autoindenting yaaaaay
set smartindent
set autoindent
" If alignment is only possible with spaces, then use spaces as well as \t
set smarttab

set wrap

"
" Window movement
"

map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l
" Sideways tab movement
" map <C-h> gT
" map <C-l> gt

" Preview window - e.g. "Ctrl-w }" or :ptag window
set previewheight=25

"
" Tab colors
"
hi TabLine      cterm=NONE ctermbg=grey  ctermfg=black 
hi TabLineFill  cterm=NONE ctermbg=grey 

"
" Statusline configuration
"

" Colours
hi StatusLine   cterm=bold ctermfg=white ctermbg=black
hi StatusLineNC cterm=NONE ctermfg=grey  ctermbg=black

set laststatus=1		" Only display a statusline on the last window
				" if there are more than two windows

" set laststatus=2		" Always display a statusline on the last window

set statusline=%m\ 		" Modified flag
set statusline+=%f		" Relative path
set statusline+=\ %y		" Display filetype
set statusline+=%=		" Switch to right side
set statusline+=[%l/%L]\ 	" Display line/LINES
set statusline+=(%v)\ 		" Display vcol
" set statusline+=%c%V\ 	" Display col - vcol
" set statusline+=%v\ 		" Display vcol
