" File:        vimPersonal.vim
" Description: Vim global plugin that provides some nice functions for Ian
" Maintainer:  Ian Mouzon <imouzon @ iastate dot edu>
" Last Change: 15 January, 2015
" License:     This program is free software. It comes without any warranty,
"              to the extent permitted by applicable law. You can redistribute
"              it and/or modify it under the terms of the Do What The Fuck You
"              Want To Public License, Version 2, as published by Sam Hocevar.
"              See http://sam.zoy.org/wtfpl/COPYING for more details.
"
" ============================================================================
"
" SECTION: Initializing stuff
"============================================================
if exists("loaded_vimPersonal")
    finish
endif
if v:version < 700
    echoerr "vimPersonal: this plugin requires vim >= 7."
    finish
endif

let loaded_vimPersonal = 1

" SECTION: Headers and Timestamps
"============================================================
"filetypes that have headers
" autoload/HeadersAndTimestamps.vim

autocmd bufnewfile *.R,*.Renviron,*.Rprofile *.c,*.cpp, *.lisp,*.lsp, *.java, *.sas, *.tex, *.rnw, *.rmd, *.f,*.for, *.js,*.javascript call HeadersAndTimestamps#func()

"set timestamp automatically
autocmd bufnewfile *.css,*.java,*.js,*.javascript,*.c,*.cpp,*.lsp,*.lisp,*.R,*.Renviron,*.Rprofile,*.tex,*.rnw,*.sas,*.f,*.for call AddTimestamp#func(1)

"update timestamp automatically
autocmd Bufwritepre,filewritepre *.css,*.java,*.js,*.javascript,*.c,*.cpp,*.lsp,*.lisp,*.R,*.Renviron,*.Rprofile,*.tex,*.rnw,*.rmd,*.sas,*.f,*.for  call g:AddTimestamp(0)


" SECTION: python 
"============================================================
"source ~/.vim/bundle/vimPersonal/plugin/vimpy.vim


" SECTION: Impact server
"============================================================
"source ~/.vim/bundle/vimPersonal/plugin/R_impact_server.vim


" SECTION: CSV work
"============================================================
" :Csv 1    " highlight first column
" :Csv 12   " highlight twelfth column
" :Csv 0    " switch off highlight
"source ~/.vim/bundle/vimPersonal/plugin/vimCSV.vim


" SECTION: R integration
"============================================================
"source ~/.vim/bundle/vimPersonal/plugin/Rintegration.vim

" SECTION: vim color functions
"============================================================
"source ~/.vim/bundle/vimPersonal/plugin/vim_color_functions.vim


" SECTION: Change directory
"============================================================
" File: CD.vim
" Author: Me
" Description: Change directories to location of file in current buffer
" Last Modified: September 21, 2013

command! CD cd %:p:h

" SECTION: Create course directory
"source ~/.vim/bundle/vimPersonal/plugin/CreateCourseDirectory.func.vim

"Transpose buffer
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

