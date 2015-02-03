" File:        HeadersAndTimestamps.vim
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
let available_header_file_extensions = "R Renviron Rprofile c cpp css f for java lisp lsp rnw sas tex vim"

"Function: g:AddHeader() function 
"Adds headers to newly created files
"
"Args:
"ftvar: the type of file being created
"
"Returns:
"1 if the no errors were encountered, 0 otherwise

"Headers for R, FORTRAN, SAS, C, JAVA, LISP, TeX files
function! g:AddHeader(ftvar)
   if a:ftvar == 'R'
      execute 'so ~/.vim/bundle/vimPersonal/headers/R_header.txt'
   endif

   if a:ftvar == 'C'
      execute 'so ~/.vim/bundle/vimPersonal/headers/C_header.txt'
   endif

   if a:ftvar == 'Lisp'
      execute 'so ~/.vim/bundle/vimPersonal/headers/Lisp_header.txt'
   endif

   if a:ftvar == 'java'
      execute 'so ~/.vim/bundle/vimPersonal/headers/java_header.txt'
   endif

   if a:ftvar == 'SAS'
      execute 'so ~/.vim/bundle/vimPersonal/headers/SAS_header.txt'
   endif

   if a:ftvar == 'TeX'
      execute 'so ~/.vim/bundle/vimPersonal/headers/TeX_header.txt'
      execute "1,".2."g/For LaTeX-Box: root \=/s//For LaTeX-Box: root \= ".expand("%:r").".tex"
   endif

   if a:ftvar == 'Rnoweb'
      execute 'so ~/.vim/bundle/vimPersonal/headers/Rnoweb_header.txt'
      execute "1,".2."g/For LaTeX-Box: root \=/s//For LaTeX-Box: root \= ".expand("%:r").".tex"

      let workingdir = 'working.dir = "'.expand('%:p:h').'"'
      execute "11,".25."s,#working.dir \= '\.',".workingdir.','
      execute "11,".25."s,#setwd(working.dir),setwd(working.dir),"
   endif

   if a:ftvar == 'Rmarkdown'
      execute 'so ~/.vim/bundle/vimPersonal/headers/Rmarkdown_header.txt'
   endif

   if a:ftvar == 'Fortran'
      execute 'so ~/.vim/bundle/vimPersonal/headers/Fortran_header.txt'
   endif
  
   "Add file name to the header
   exe "2," . 9 . "g/File Name:.*/s//File Name: " .expand("%")
endfunction

autocmd bufnewfile *.R,*.Renviron,*.Rprofile call g:AddHeader('R')
autocmd bufnewfile *.c,*.cpp call g:AddHeader('C')
autocmd bufnewfile *.lisp,*.lsp call g:AddHeader('Lisp')
autocmd bufnewfile *.java call g:AddHeader('java')
autocmd bufnewfile *.sas call g:AddHeader('SAS')
autocmd bufnewfile *.tex call g:AddHeader('TeX')
autocmd bufnewfile *.rnw call g:AddHeader('Rnoweb')
autocmd bufnewfile *.rmd call g:AddHeader('Rmarkdown')
autocmd bufnewfile *.f,*.for call g:AddHeader('Fotran')

"Function: g:AddTimestamp() function 
"Adds timestamps when files are saved
"
"Args:
"timestamp_newfile: adds creation date
"
"Returns:
"1 if the no errors were encountered, 0 otherwise
function! g:AddTimestamp(timestamp_newfile)
   if a:timestamp_newfile == 1
      execute "2," . 9 . "g/Creation Date:.*/s//Creation Date: " .strftime("%d-%m-%Y")
      execute "normal G"
   endif

   "Add time saved to file
   execute "normal mp"
   execute "2," . 9 . "g/Last Modified:.*/s/Last Modified:.*/Last Modified: " .strftime("%c")
   execute "normal `p"
endfunction

"set timestamp automatically
autocmd bufnewfile *.css,*.java,*.c,*.cpp,*.lsp,*.lisp,*.R,*.Renviron,*.Rprofile,*.tex,*.rnw,*.sas,*.f,*.for call g:AddTimestamp(1)

"update timestamp automatically
autocmd Bufwritepre,filewritepre *.css,*.java,*.c,*.cpp,*.lsp,*.lisp,*.R,*.Renviron,*.Rprofile,*.tex,*.rnw,*.rmd,*.sas,*.f,*.for  call g:AddTimestamp(0)


