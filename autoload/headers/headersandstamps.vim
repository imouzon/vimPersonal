"filetypes that have headers
let available_header_file_extensions = "R Renviron Rprofile c cpp css f for java lisp lsp rnw sas tex vim"

"Headers for R, FORTRAN, SAS, C, JAVA, LISP, TeX files
   autocmd bufnewfile *.R,*.Renviron,*.Rprofile so  /Users/user/.vim/vim_personal/headersandtimestamps/R_header.txt
   autocmd bufnewfile *.c,*.cpp so  /Users/user/.vim/vim_personal/headersandtimestamps/C_header.txt
   autocmd bufnewfile *.lisp,*.lsp so  /Users/user/.vim/vim_personal/headersandtimestamps/Lisp_header.txt
   autocmd bufnewfile *.java so  /Users/user/.vim/vim_personal/headersandtimestamps/java_header.txt
   autocmd bufnewfile *.sas so  /Users/user/.vim/vim_personal/headersandtimestamps/SAS_header.txt
   autocmd bufnewfile *.tex so  /Users/user/.vim/vim_personal/headersandtimestamps/TeX_header.txt
   autocmd bufnewfile *.rnw so  /Users/user/.vim/vim_personal/headersandtimestamps/Rnoweb_header.txt
   autocmd bufnewfile *.rmd so  /Users/user/.vim/vim_personal/headersandtimestamps/Rmarkdown_header.txt
   autocmd bufnewfile *.f,*.for so  /Users/user/.vim/vim_personal/headersandtimestamps/Fortran_header.txt
   autocmd bufnewfile *.css so /Users/user/.vim/vim_personal/headersandtimestamps/web_header.txt

"Add time stamps to new files showing creation date
"Notice that FORTRAN positions you at the correct column (column 7)
   autocmd bufnewfile *.css,*.java,*.c,*.cpp,*.lsp,*.lisp,*.R,*.Renviron,*.Rprofile,*.tex,*.rnw,*.sas,*.f,*.for exe "2," . 9 . "g/File Name:.*/s//File Name: " .expand("%")
   autocmd bufnewfile *.tex exe "1," . 9 . "g/For LaTeX-Box: root \=/s//For LaTeX-Box: root \= " .expand("%:r").".tex"
   autocmd bufnewfile *.rnw exe "1," . 9 . "g/For LaTeX-Box: root \=/s//For LaTeX-Box: root \= " .expand("%:r").".tex"
   autocmd bufnewfile *.rnw exe "1,$g/file\.directory \= /s//file\.directory \= \'".expand("%:p:h")."\'"
   autocmd bufnewfile *.css,*.java,*.c,*.cpp,*.lsp,*.lisp,*.R,*.Renviron,*.Rprofile,*.tex,*.rnw,*.rmd,*.sas,*.f,*.for exe "2," . 9 . "g/Creation Date:.*/s//Creation Date: " .strftime("%d-%m-%Y")
   autocmd bufnewfile *.css,*.java,*.c,*.cpp,*.lsp,*.lisp,*.R,*.Renviron,*.Rprofile,*.tex,*.rnw,*.rmd,*.sas,*.f,*.for execute "normal G"

"Add time saved to file
   autocmd Bufwritepre,filewritepre *.css,*.java,*.c,*.cpp,*.lsp,*.lisp,*.R,*.Renviron,*.Rprofile,*.tex,*.rnw,*.rmd,*.sas,*.f,*.for execute "normal mp"
   autocmd Bufwritepre,filewritepre *.css,*.java,*.c,*.cpp,*.lsp,*.lisp,*.R,*.Renviron,*.Rprofile,*.tex,*.rnw,*.rmd,*.sas,*.f,*.for exe "2," . 9 . "g/Last Modified:.*/s/Last Modified:.*/Last Modified: " .strftime("%c")
   autocmd bufwritepost,filewritepost *.css,*.java,*.c,*.cpp,*.lsp,*.lisp,*.R,*.Renviron,*.Rprofile,*.tex,*.rnw,*.rmd,*.sas,*.f,*.for execute "normal `p"

"Some stuff I tried to make this code into a list
"Add header to pre-existing file
   "command! AddHeader 
   "Need to write function that will do this 

"make a list
"let header_file_exts = split(available_header_file_extensions)

"Create variables for header filename and header file path
"let ians_vim_filename = expand("%")
"let ians_vim_filetype = &filetype
"let ians_vim_fileext = fnamemodify(bufname("%"),":t")
"let ians_vim_filepath = expand("%:p")
"let ians_vim_folder   = expand("%:p:h")
"echo ians_vim_fileext

"what is my current file called?
"let ians_vim_fileext = fnamemodify(bufname("%"),":t")
"
"let g:ians_header_type = 'FALSE'
"let loop_i = 1
"while loop_i < len(header_file_exts)
"if matchstr(ians_vim_fileext,header_file_exts[loop_i]) ==? header_file_exts[loop_i]
"   let ians_header_type = header_file_exts[loop_i]
"endif
"let loop_i = loop_i + 1
"endwhile
