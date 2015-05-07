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
" SECTION: Initialization
"============================================================
if exists("loaded_vimPersonal")
    finish
endif

if v:version < 700
    echoerr "vimPersonal: this plugin requires vim >= 7."
    finish
endif

let loaded_vimPersonal = 1

let s:vimPersoanl_path = escape(expand('<sfile>:p:h'),'\')

" SECTION: Headers and Timestamps
"============================================================
"filetypes that have headers
" autoload/HeadersAndTimestamps.vim

autocmd bufnewfile *.R,*.Renviron,*.Rprofile *.c,*.cpp, *.lisp,*.lsp, *.java, *.sas, *.tex, *.rnw, *.rmd, *.f,*.for, *.js,*.javascript call vimPersonal#AddHeader()

"set timestamp automatically
autocmd bufnewfile *.css,*.java,*.js,*.javascript,*.c,*.cpp,*.lsp,*.lisp,*.R,*.Renviron,*.Rprofile,*.tex,*.rnw,*.sas,*.f,*.for call vimPersonal#AddTimestamp(1)

"update timestamp automatically
autocmd Bufwritepre,filewritepre *.css,*.java,*.js,*.javascript,*.c,*.cpp,*.lsp,*.lisp,*.R,*.Renviron,*.Rprofile,*.tex,*.rnw,*.rmd,*.sas,*.f,*.for  call vimPersonal#AddTimestamp(0)

" SECTION: python 
"============================================================
"call vimPersonal#ScreenSessions()

"nnoremap <Leader>ip :call vimPersonal#ScreenSessions('vimpy')<CR>
"nnoremap <Leader>iq :execute '!screen -X -S vimpy quit'<CR>

"command! Vimpy call vimPersonal#ScreenSessions('vimpy')


" SECTION: Impact server
"============================================================
"source ~/.vim/bundle/vimPersonal/plugin/R_impact_server.vim
"do it from shell instead
nmap <Leader>ssh :call vimPersonal#Impact()<CR>
nmap <Leader>ssh2 :call vimPersonal#Impact(2)<CR>
nmap <Leader>ssh3 :call vimPersonal#Impact(3)<CR>
nmap <Leader>ssh4 :call vimPersonal#Impact(4)<CR>

nmap <Leader>sshR :call vimPersonal#RtoSSH()<CR>


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
call vimPersonal#ColorMe("dark")

" SECTION: Change directory
"============================================================
" File: CD.vim
" Author: Me
" Description: Change directories to location of file in current buffer
" Last Modified: September 21, 2013

command! CD cd %:p:h

" SECTION: Create course directory
"source ~/.vim/bundle/vimPersonal/plugin/CreateCourseDirectory.func.vim

" SECTION: knitr
command! KnitQ call vimPersonal#KnitVim("knitsilent","compileTeX","openPDF")
command! KnitL call vimPersonal#KnitVim("compileTeX","openPDF")
command! KnitR call vimPersonal#KnitVim("usingRmacros","compileTeX","openPDF")
command! KnitD call vimPersonal#KnitDebug()

nnoremap <silent> <Leader>kk :call vimPersonal#KnitVim("knitsilent","compileTeX")<CR>
nnoremap <silent> <Leader>kj :call vimPersonal#KnitVim("compileTeX")<CR>
nnoremap <silent> <Leader>kr :call vimPersonal#KnitVim("knitsilent","usingRmacros","compileTeX")<CR>
nnoremap <silent> <Leader>kd :call vimPersonal#KnitDebug()<CR> 

"command! GiveRF !cp %:p ~/FORTRAN/subroutines/f/%:r.f; R CMD SHLIB ~/FORTRAN/subroutines/f/%:r.f; mv ~/fortran/subroutines/f/%:r.so ~/fortran/subroutines/so/%:r.so; cp ~/FORTRAN/subroutines/f/%:r.f ~/R/shlib/code/%:r.f; cp ~/FORTRAN/subroutines/so/%:r.so ~/R/shlib/so/%:r.so;
"command! GiveRC !cp %:p ~/C/functions/C/%:r.c; R CMD SHLIB ~/C/functions/C/%:r.c; mv ~/C/functions/f/%:r.so ~/C/functions/so/%:r.so; cp ~/C/functions/f/%:r.c ~/R/shlib/C/%:r.c; cp ~/C/functions/so/%:r.so ~/R/shlib/so/%:r.so;

"command! GiveR call GiveRfiletype()
"command! AddR !echo 'dyn.load(\'~/R/shlib/so/%:r.so\')' >> ~/R/shlib/C_FORTRAN.shlib.R; echo 'pck.load[[1]]<-unique(c(pck.load[[1]],\'%:r\'))' >> ~/R/shlib/C_FORTRAN.shlib.R

" SECTION: Losing focus
let g:LosingFocus_run = 0

if empty(g:LosingFocusPackages)
   let g:LosingFocusPackages = [["AutoCorrect"]]
endif

au FocusLost * call vimPersonal#LosingFocus()


" SECTION: myAutoCorrect
call vimPersonal#MyAutoCorrect()

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
