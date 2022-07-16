setl indentexpr=SaneVerilogIndent()
setl indentkeys=!^F,o,O,0),=begin,=end,=join,=else

" Only define the function once.
" if exists("*SaneVerilogIndent")
" 	finish
" endif

function! SaneVerilogIndent ()
	let offset = &sw

	" Find a non-blank line above the current line.
	let lnum = prevnonblank(v:lnum - 1)
	if lnum == 0
		return 0
	endif

	let prev_line = getline(lnum)
	let curr_line = getline(v:lnum)
	let ind = indent(lnum)

	" simple end of line indentation
	"if curr_line =~ '.*\c\(end\)\s*$'
	"	return ind - offset
	"else
	if prev_line =~ '.*\c\(begin\|(\)\s*$'
		return ind + offset
	endif

	return -1
endfunction
