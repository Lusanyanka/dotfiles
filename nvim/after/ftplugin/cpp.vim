setl tw=80
setl cindent
setl shiftwidth=4
setl tabstop=4
setl noexpandtab
" grep for the word under the cursor in the current directory recursively
nmap <buffer> <leader>k "cyiw:!grep <c-r>c -r . -I <CR>
" rebuild mapping
nmap <buffer> <leader>r :w<CR>:make<CR>
