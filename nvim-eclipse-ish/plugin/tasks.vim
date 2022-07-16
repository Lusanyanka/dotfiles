" TODO:
"  - show line number and file name
"  - show more than one line after search terms
"  - display results in a separate split
"  - make it possible to jump to the line in question
"  - expand/collapse description beneath terms
function! ShowTaskWindow()
    for word in ["FIXME", "TODO", "XXX"]
        execute "vimgrep /".word."/j **/*"
        for i in getqflist()
            let splits = split(i["text"], "\\\(".word."\[:\]* \\\| \\\*/\\\)")
            echo printf("%6s: %s", word, get(splits, 1, "!!!"))
        endfor
    endfor
endfunction
