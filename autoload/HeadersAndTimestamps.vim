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

"Function: g:AddHeader() function 
"Adds headers to newly created files
"
"Args:
"ftvar: the type of file being created
"
"Returns:
"1 if the no errors were encountered, 0 otherwise


"Headers for R, FORTRAN, SAS, C, JAVA, LISP, TeX files
function! vimPersonal#AddHeader()
   let available_header_file_extensions = "R c cpp css f for java javascript lisp lsp rnw sas tex vim"
   "general parameters
   " directory path:      expand('%:p:h')
   " filename (with ext): expand("%:t")
   " filename (no ext):   expand("%:t:r")
   " fext = expand("%:t:e")
   
   let ftvar = expand("%:t:e")

   let header_loc = escape(expand('<sfile>:p:h'),'\')

   if filereadable(expand('%:p:h:h').'/NAMESPACE')
      let ftvar = "rdev"
   else
      let ftvar = tolower(a:ftvar)
   endif

   execute 'so '.header_loc.a:ftvar."_header.vim"

   "Add file name to the header
   exe "%s/2," . 9 . "g/File Name:.*/s//File Name: " .expand("%")."/e"

   if ftvar == 'tex'
      execute "s1,2/For LaTeX-Box: root \=/For LaTeX-Box: root \= ".expand("%:r").".tex/e"

   elseif ftvar == 'rnoweb'
      let workingdir = 'working.dir = "'.expand('%:p:h').'"'
      execute "%s/#working\.dir \= \"\.\"/".workingdir."/e"
      execute "%s/#setwd(working.dir)/setwd(working.dir)/e"

   elseif ftvar == 'rmarkdown'
      let workingdir = 'working.dir = "'.expand('%:p:h').'"'
      let render = 'render("'.expand('%:p').'")'
      execute "%s/#working.dir \= '\.'/".workingdir.'/e'
      execute "%s/#setwd(working.dir)/setwd(working.dir)/e"
      execute "%s/render(pathtofile)/".render."/e"
      execute "%s/#if(FALSE)/if(FALSE)/e"

   endif

endfunction
