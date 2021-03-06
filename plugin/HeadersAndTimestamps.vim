" ============================================================================
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
let available_header_file_extensions = "R Renviron Rprofile c cpp python css f for java javascript lisp lsp rnw sas tex vim"

function! g:AddPythonHeader()

   if has('nvim')
      let header_path = plug_path . "vimPersonal/autoload/headers/"
      let plug_path = "~/.config/nvim/plugged/"
   else
      let plug_path = "~/.vim/plugged/"
   endif

endfunction

"Headers for R, FORTRAN, SAS, C, JAVA, LISP, TeX files
function! g:AddHeader(ftvar)
   
   if has('nvim')
      let plug_path = "~/.config/nvim/plugged/"
   else
      let plug_path = "~/.vim/plugged/"
   endif

   let header_path = plug_path . "vimPersonal/autoload/headers/"

   "using ==? for case insensitive comparison for file end: 'r' = 'R', 'c' = 'C', etc.
   
   "R files can be in a package or stand alone
   if a:ftvar ==? 'R'

      "If there is a NAMESPACE file in the parent level, it's an Rdev
      if filereadable(expand('%:p:h:h').'/NAMESPACE')
         "execute 'so ' . header_path . 'Rdev_header.txt'
         execute 'so ' . header_path . 'Rdev_header.txt'
      else
         execute 'so ' . header_path . 'R_header.txt'
      endif

   elseif a:ftvar ==? 'python'

      execute 'so ' . header_path . 'python_header.txt'

   elseif a:ftvar ==? 'C'

      execute 'so ' . header_path . 'C_header.txt'

   elseif a:ftvar ==? 'Lisp'

      execute 'so ' . header_path . 'Lisp_header.txt'

   elseif a:ftvar ==? 'java'

      execute 'so ' . header_path . 'java_header.txt'

   elseif a:ftvar ==? 'javascript'

      execute 'so ' . header_path . 'js_header.txt'

   elseif a:ftvar ==? 'SAS'

      execute 'so ' . header_path . 'SAS_header.txt'

   elseif a:ftvar ==? 'TeX'

      execute 'so ' . header_path . 'TeX_header.txt'
      execute "1,".2."g/For LaTeX-Box: root \=/s//For LaTeX-Box: root \= ".expand("%:r").".tex"

   elseif a:ftvar ==? 'Rnoweb'

      let workingdir = "working.dir = \"".expand("%:p:h")."\""
      execute "11,".25."s,#working\.dir \= \"\.\",".workingdir.","
      execute "11,".25."s,#setwd(working.dir),setwd(working.dir),"

   elseif a:ftvar ==? 'Fortran'

      execute 'so ' . header_path . 'Fortran_header.txt'

   elseif a:ftvar ==? 'Rmarkdown'

      execute 'so ' . header_path . 'Rmarkdown_header.txt'
      let workingdir = 'working.dir = "'.expand('%:p:h').'"'
      let render = 'render("'.expand('%:p').'")'
      let lnumb = line('$')
      execute "20,".lnumb."s,#working.dir \= '\.',".workingdir.','
      execute "20,".lnumb."s,#setwd(working.dir),setwd(working.dir),"
      execute "20,".lnumb."s,render(pathtofile),".render.","

   elseif a:ftvar ==? "ghissue"

      execute 'so ' . header_path . 'ghissue_header.txt'

   endif
  
   "Add file name to the header
   exe "2,$g/File Name:.*/s//File Name: " .expand("%")

endfunction

"autocmd bufnewfile *.dev.R call g:AddHeader('Rdev')
autocmd bufnewfile *.c,*.cpp call g:AddHeader('C')
autocmd bufnewfile *.R,*.Renviron,*.Rprofile call g:AddHeader('R')
autocmd bufnewfile *.rnw call g:AddHeader('Rnoweb')
autocmd bufnewfile *.rmd call g:AddHeader('Rmarkdown')
autocmd bufnewfile *.lisp,*.lsp call g:AddHeader('Lisp')
autocmd bufnewfile *.java call g:AddHeader('java')
autocmd bufnewfile *.sas call g:AddHeader('SAS')
autocmd bufnewfile *.tex call g:AddHeader('TeX')
autocmd bufnewfile *.f,*.for call g:AddHeader('Fortran')
autocmd bufnewfile *.js,*.javascript call g:AddHeader('javascript')
autocmd bufnewfile *.py,*.python call g:AddHeader('python')
autocmd bufnewfile *.issue.md call g:AddHeader("ghissue")

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
      execute "2,$g/Creation Date:.*/s//Creation Date: " .strftime("%d-%m-%Y")
      execute "normal G"
   endif

   "Add time saved to file
   execute "normal mp"
   execute "2,$g/Last Modified:.*/s/Last Modified:.*/Last Modified: " .strftime("%c")
   execute "normal `p"
endfunction

"set timestamp automatically
"autocmd bufnewfile *.css,*.java,*.js,*.javascript,*.c,*.cpp,*.py,*.lsp,*.lisp,*.R,*.Renviron,*.Rprofile,*.tex,*.rnw,*.sas,*.f,*.for call g:AddTimestamp(1)

"update timestamp automatically
"autocmd Bufwritepre,filewritepre *.css,*.java,*.js,*.javascript,*.c,*.cpp,*.py,*.lsp,*.lisp,*.R,*.Renviron,*.Rprofile,*.tex,*.rnw,*.rmd,*.sas,*.f,*.for  call g:AddTimestamp(0)
