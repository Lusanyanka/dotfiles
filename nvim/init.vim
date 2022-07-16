" TODO: look at using stdpath()
set so=5
set siso=5

set wildmenu
set ignorecase
set smartcase
set shiftwidth=4
set tabstop=4
set noexpandtab
set smartindent
set autoindent
set smarttab
set wrap
set nobackup
set noswapfile
set novisualbell
syntax enable

" Nifty search highlighting on search and disable with F4
set nohlsearch
noremap / :set hlsearch<CR>/
noremap * :set hlsearch<CR>*
noremap <F2> :set hlsearch! hlsearch?<CR>
set magic
" noremap n nzz
" noremap N Nzz

" Toggle paste modes
:noremap <F4> :set paste! nopaste?<CR>

" Toggle line numbers
:noremap <F3> :set nonumber! nonumber?<CR>

" set belloff+=ecs
" set belloff+=wildmode
" set belloff+=backspace
" Turn off all bell sounds
set belloff+=all

set mouse=a
set nocompatible
filetype plugin on
runtime! ftplugin/man.vim
let g:tex_flavor = "latex"

" disable shada in neovim
if (has('nvim'))
	set shada=
endif

" Format options reference
"
"  sensible options:
"    j - remove comment leader on joining
"    n - recognize lists (with 'formatlistpat')
"    c - autowrap comments
"    r - insert comment leader on <Enter>
"    o - insert comment leader on 'o' or 'O'
"    q - allow 'gq' on comments
"    1 - don't break after a one-letter word, break before
"
"  tex'y options:
"    t - autowrap text
"    w - trailing whitespace continues a paragraph
"    2 - Indent by second (not first) line of a paragraph. Req: 'autoindent'
"    a - automatic formatting of paragraphs. With 'c' only format comments.
"
"  compat options:
"    v - only break a line at a blank in the current insert command
"    b - do not autowrap without blanks or if it was longer than 'textwidth'
"    l - do not autowrap if the line started longer than 'textwidth'
"  multi-byte options:
"    m - break at multi-byte characters above 255
"    M - don't insert spaces around multibyte chars on line joins
"    B - don't insert spaces between two multibyte chars on line joins
set fo=jncroql

" Format List Pattern:
" regex to match a list in a comment for indentation on the next line
" default: formatlistpat=^\\s*\\d\\+[\\]:.)}\\t\\ ]\\s*
"
" This new pattern matches lists without numbering with the extra symbols
" (which I like using to mark bulletted lists in comments) in the character
" range after the digits, as well as normal numbered lists.
set formatlistpat=^\\s*[0-9\\]:.)}\\->*]\\+\\s\\+

" Set tags to search current dir for tags, all the way up to $HOME
set tags=./tags,tags;$HOME

" Sudo trick to write out a file as superuser
command! SudoWrite w !sudo tee >/dev/null %

"
" Leader shortcuts
"
" Map space as leader
nnoremap <SPACE> <Nop>
let mapleader = " "
let g:mapleader = " "

nmap <leader>w :w<cr>
nmap <leader>q :q<cr>
" Substitute through the whole buffer
nmap <leader>s :%s/
" Toggle fold open/closed
nmap <leader>z za
" Fold between matching symbols
nmap <leader>f zf%
" Use register c ["c] to yank the word under the cursor [yiw] and start a
" substitution in the current buffer [:%s/] with the word in register c
" [<C-r>c].
nmap <leader>h "cyiw:%s/\<<C-r>c\>/
" moving around in buffers
nmap <leader>, :bnext<CR>
nmap <leader>. :bprevious<CR>
nmap <leader>l :ls<CR>

"
" Swap tag and ptjump
"
nnoremap <c-]> g<c-]>
vnoremap <c-]> g<c-]>
nnoremap g<c-]> <c-]>
vnoremap g<c-]> <c-]>

"
" Window movement
"
" TODO: use alt keys instead? <A-h> instead of <C-h>
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l
" mappings for :terminal window
tnoremap <C-h> <C-\><C-n><C-w>h
tnoremap <C-j> <C-\><C-n><C-w>j
tnoremap <C-k> <C-\><C-n><C-w>k
tnoremap <C-l> <C-\><C-n><C-w>l
" remap Esc to return to normal mode in :terminal
tnoremap <Esc> <C-\><C-n>


" Preview window - e.g. "Ctrl-w }" or :ptag window
set previewheight=20

set cc=+1

set bg=dark
hi Search       ctermbg=11 ctermfg=0
hi ColorColumn	ctermbg=8
hi Folded		ctermbg=8  ctermfg=3

" Tab pages color
hi TabLine      cterm=NONE ctermbg=black	ctermfg=grey
hi TabLineFill  cterm=NONE ctermbg=black

" Vertical seperator
set fcs+=vert:│
hi VertSplit    cterm=NONE ctermfg=grey	ctermbg=black

" CursorLine
hi CursorLine	cterm=NONE ctermfg=NONE	ctermbg=235

" Statusline configuration
" Colours
hi StatusLine   cterm=NONE ctermfg=0  ctermbg=7
hi StatusLineNC cterm=NONE ctermfg=15 ctermbg=8

" WildMenu completions and insert completions
hi Pmenu        cterm=bold ctermfg=15 ctermbg=8
hi PmenuSel     cterm=NONE ctermfg=0  ctermbg=13

set completeopt=menu,longest,preview
set wildmode=longest:full

set laststatus=2

set statusline=%m\ 			" Modified flag
set statusline+=%f			" Relative path
set statusline+=\ %y		" Display filetype
set statusline+=%=			" Switch to right side
set statusline+=[%l/%L]\ 	" Display line/total
set statusline+=(%v)\ 		" Display visual column
" set statusline+=%c%V\ 	" Display col - vcol

let g:netrw_liststyle=3 " tree listing
let g:netrw_browse_split=0 " open files in a previous window

" autocmds to save views
set viewoptions=folds,cursor
augroup AutoSaveFolds
	autocmd!
	autocmd BufWinLeave,BufLeave ?* silent! mkview
	autocmd BufWinEnter ?* silent! loadview
augroup END

augroup LocalCursorLine
	autocmd!
	autocmd VimEnter,WinEnter,BufWinEnter * setlocal cursorline
	autocmd WinLeave * setlocal nocursorline
augroup END

" buffer helper functions
fu! ListedBuffers()
	return filter(range(1, bufnr("$")), 'buflisted(v:val)')
endf
fu! UnlistedBuffers()
	return filter(range(1, bufnr("$")), '!buflisted(v:val)')
endf
fu! BufVisible(bn)
	return len(win_findbuf(bufnr(a:bn))) != 0
endf
fu! DisplayedBuffers()
	return filter(range(1, bufnr("$")), 'BufVisible(v:val)')
endf
" check for a visible help window in the current tab
fu! VisibleHelpBuffer()
	return len(filter(
			\ tabpagebuflist(),
			\ 'getbufvar(v:val, "current_syntax", "") == "help"'
		\)) != 0
endf

" remap :q to change the buffer and close the previous one unless:
"  - this is the only displayed buffer open
"  - the current buffer is the only one present
"  - this buffer is some periperal function, like the command window, help,
"    preview, NERDTree, etc.
"  - there's a help window open on this tab
" TODO: close tab when called in the last window in a tab that isn't the only
"       open tab
function! ShiftAndCloseCurrentBuffer()
	" !buflisted: check if the current window is unlisted -- these should
	"             usually just be closed with a :q
	" [Command Line]: detect [Command Line] mode, which, for some reason, is
	"                 actually a listed window
	" len(tabpagebuflist()): check that this is the only displayed buffer on
	"                        the current tab. This specifically addresses the
	"                        case where I open a new tab to do quick edits on
	"                        a distant file (like init.vim), and then want to
	"                        close the tab and return to the file I was just
	"                        editing.
	let vis = DisplayedBuffers()
	if (!buflisted(bufnr("%"))
		\ || bufname("%") == "[Command Line]"
		\ || bufname("%") == ""
		\ || (len(tabpagebuflist()) == 1
			\ && len(ListedBuffers()) == 1)
		\)
		" empty file with only NERDTree displayed
		if (len(filter(vis,
				\'getbufvar(v:val, "NERDTree", {}) == {}')) == 1
			\ && len(filter(vis, 'bufname(v:val) ~ "\S"')) == 1)
			quitall
		endif
		confirm quit
	else
		" check for a open help window in the tab. Sometimes I want to have
		" only a help window open for reference, and this allows me to issue
		" just a regular 'q' in that case.
		if (len(tabpagebuflist()) == 2 && VisibleHelpBuffer() == 1)
			confirm bdelete
		else
			bnext
			" check if the buffer is displayed in another window
			if (!BufVisible("#")) | confirm bdelete # | endif
		endif
	endif
endfunction

fu! WriteWrapper()
	w
	call ShiftAndCloseCurrentBuffer()
endfu
fu! WriteQuitWrapper()
	w
    quit
endfu
" make a fancy cnoreabbrev alias for a command, which allows redefinition
" lowercase commands
function! MakeAlias (alias, ...)
	exec 'cnoreabbrev <expr> '.a:alias
		\.' ((getcmdtype() ==# ":" && getcmdline() ==# "'.a:alias.'")'
		\.' ? ("'.join(a:000[0:]).'") : ("'.a:alias.'"))'
endfunction
command! -nargs=+ Alias :exec MakeAlias(<f-args>)
Alias Q quit<CR>
Alias q call ShiftAndCloseCurrentBuffer()
Alias wq call WriteWrapper()
Alias wQ call WriteQuitWrapper()

" Use 8-space tabs, according to reStructedText standard
let g:rst_style=0

" PLUGINS
" automatically grab vim-plug
" look I know it's bad, but I'm also lazy and my trust is cheap
if (has('nvim'))
if empty(glob('~/.local/share/nvim/site/autoload/plug.vim'))
  silent !curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs
	\ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif
else
if empty(glob("~/.vim/autoload/plug.vim"))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
	\ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif
endif

if (has('nvim'))
	call plug#begin('~/.local/share/nvim/vim-plugs')
else
	call plug#begin('~/.vim/plugged')
endif

Plug 'tpope/vim-vinegar' " netrw enhancements
Plug 'michaeljsmith/vim-indent-object' " `i` object
Plug 'b4winckler/vim-angry' " `a` object
Plug 'SirVer/ultisnips' " snippy snippy snips
Plug 'scrooloose/nerdtree' " sidebar for files
" Plug 'Xuyuanp/nerdtree-git-plugin'
" Plug 'sophacles/vim-processing' " working with Processing
" Plug '~/workspace/dotfiles/nvim-eclipse-ish'
Plug 'aklt/plantuml-syntax'
Plug 'christoomey/vim-tmux-navigator'

call plug#end()

" vim-tmux-navigator
let g:tmux_navigator_no_mappings = 1
"TODO:
"nnoremap <silent> <m-h> :TmuxNavigateLeft<cr>
"nnoremap <silent> <m-j> :TmuxNavigateDown<cr>
"nnoremap <silent> <m-k> :TmuxNavigateUp<cr>
"nnoremap <silent> <m-l> :TmuxNavigateRight<cr>
"nnoremap <silent> <m-w> :TmuxNavigatePrevious<cr>

" Ultisnips
let g:UltiSnipsExpandTrigger="<Tab>"
let g:UltiSnipsListTrigger="<S-Tab>"
let g:UltiSnipsJumpForwardTrigger="<Tab>"
let g:UltiSnipsJumpBackwardTrigger="<S-Tab>"
if (has('nvim'))
	let g:UltiSnipsSnippetsDir="~/.config/nvim/ultisnips"
endif
let g:UltiSnipsSnippetDirectories=["ultisnips", "UltiSnips"]
let g:UltiSnipsEditSplit="horizontal"
Alias ue UltiSnipsEdit
" let g:UltiSnipsEditSplit="vertical"

" NERDTree
let NERDTreeIgnore=['\~$'
            \, '\.\(class\|[oad]\)$[[file]]'
            \, '\.\(aux\|out\|fdb_latexmk\|fls\|pdf\)$[[file]]'
			\, '\.\(sdf\|sdc\|vcd\|vpd\)$[[file]]'
			\, '^simv\(\.daidir\)\=$[[dir]]'
            \, '\.docx\=$[[file]]'
            \]
let NERDTreeWinSize=30
let NERDTreeMinimalUI=1
let NERDTreeNaturalSort=1
let NERDTreeQuitOnOpen=0
let NERDTreeCustomOpenArgs={
			\'file': {'reuse':'all', 'where':'p', 'keepopen':1, 'stay':1}
			\,'dir': {}
			\}
augroup AutoNERDTree
    au!
    au StdinReadPre * let s:std_in=1
    " auto open if there are no arguments when launching vim
    au vimenter *
        \ if argc() == 0 && !exists("s:std_in")
            \| NERDTree
        \| endif
    " auto open if vim's only argument is the name of a folder
    au vimenter *
        \ if argc() == 1 && isdirectory(argv(0)) && !exists("s:std_in")
            \| enew
            \| exe 'NERDTree' argv(0)
        \| endif
    au bufenter *
        \ if (len(tabpagebuflist()) == 1
			\ && exists("b:NERDTree") && b:NERDTree.isTabTree())
			\ | if (len(ListedBuffers()) == 0)
				\ | rightbelow vnew
			\ | else
				\ | rightbelow vs | bn
			\ | endif
			\ | wincmd h
			\ | vertical resize 30
        \| endif
	" automatically leave a window of it's a buffer with no name and the last
	" buffer in a tab
	au winenter *
		\ if (bufname("%") == "" && len(tabpagebuflist()) == 1)
			\ | quit
		\ | endif
augroup END
