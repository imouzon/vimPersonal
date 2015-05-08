" File: transposeBuffer.func.vim
" Author: Me
" Description: Create a command to tranpose elements in a buffer
" Last Modified: September 21, 2013


function! s:transpose()
    let maxcol = 0
    let lines = getline(1, line('$'))

    for line in lines
        let len = len(line)
        if len > maxcol 
            let maxcol = len
        endif
    endfor

    let newlines = []
    for col in range(0, maxcol - 1)
        let newline = ''
        for line in lines
            let line_with_extra_spaces = printf('%-'.maxcol.'s', line)
            let newline .= line_with_extra_spaces[col]
        endfor
        call add(newlines, newline)
    endfor

    1,$"_d
    call setline(1, newlines)
endfunction

command! TransposeBuffer call s:transpose()

