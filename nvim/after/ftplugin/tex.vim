setl textwidth=72
setl tabstop=2
setl shiftwidth=2
setl spell spelllang=en_us
setl fo+=t
" rebuild mapping
nmap <buffer> <leader>r :w<CR>:make<CR>
" setl makeprg=latexmk\ -outdir=\"`dirname\ '%'`\"\ -pdf\ -pdflatex=\"pdflatex\ -interaction=nonstopmode\"\ -cd\ '%'\ &&\ latexmk\ -c\ -cd\ \"`dirname\ '%'`\"
setl makeprg=latexmk\ -pdf\ -pdflatex=\"pdflatex\ -interaction=nonstopmode\"\ -cd\ '%'\ &&\ latexmk\ -c\ -cd\ '%'

call TexNewMathZone("M", "align", 1)
