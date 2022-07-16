setl tw=80
setl cindent
setl shiftwidth=8
setl tabstop=8
setl noexpandtab
setl cinoptions=:0
" grep for the word under the cursor in the current directory recursively
nmap <buffer> <leader>k "cyiw:!grep <c-r>c -r . -I <CR>
" rebuild mapping
nmap <buffer> <leader>r :w<CR>:make<CR>
