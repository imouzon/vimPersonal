       "update tags for files like C
       so ~/.vim/vim_personal/vim_func/update_ctags.func.vim
       autocmd BufWritePost *.cpp,*.h,*.c call UPDATE_TAGS()
       
       "Took a whole afternoon to do but tags for R
       "   Loading using pathogen now, no longer needed (09/10/13)
       "   autocmd FileType r set tags+=~/.vim/RTAGS,~/.vim/RsrcTags
       "   autocmd FileType rnoweb set tags+=~/.vim/RTAGS,~/.vim/RsrcTags

""To use vim_r_plugin send this to R
""     install.packages(c('vimcom', 'colorout', 'setwidth'))


" Easier moving in tabs and windows
    map <C-J> <C-W>j<C-W>_
    map <C-K> <C-W>k<C-W>_
    map <C-L> <C-W>l<C-W>_
    map <C-H> <C-W>h<C-W>_
    map <C-K> <C-W>k<C-W>_

"Yank from the cursor to the end of the line, to be consistent with C and D.
    nnoremap Y y$
     
"latex in nonstop mode!
   let g:Tex_CompileRule_pdf = 'pdflatex -interaction nonstopmode $*'

"--FORTRAN and C in R-----------------------------------------------------------
   command! GiveR !R CMD SHLIB %
   command! AddR !echo "dyn.load('~/fortran/%')" >> ~/R/.FORTRAN.shlib; perl -pi -e 's/\.for|\.f|\.FOR|\.F|\.c|\.C/\.so/g' ~/R/.FORTRAN.shlib; 
"-------------------------------------------------------------------------------

"--LaTeX with syntax highlighting-----------------------------------------------
   command! PygFile !pdflatex -shell-escape %
   command! KnitFile !R --no-save --no-restore -e "require(knitr); knit('%')"
   command! KnitTex !pdflatex %:r.tex
   command! KnitTex !R --no-save --no-restore -e "require(knitr); knit('%')"; pdflatex %:r.tex 
"-------------------------------------------------------------------------------


"--FORTRAN----------------------------------------------------------------------
   "au BufNewFile, BufRead *.f,*.for setf fortran
   "let do_syntax_sel_menu = 1|runtime! synmenu.vim|aunmenu &Syntax.&Show\ filetypes\ in\ menu
   "set fortran_do_enddo=1
   "set foldmethod=syntax
   "let fortran_fold=1
   "let fortran_fold_conditionals=1
   "let fortran_fold_mulilinecomments=1
   "fortran_codecomplete.vim is giving terminal vi problems
   "so ~/.vim/ftplugin/fortran_codecomplete.vim
   "so ~/.vim/ftplugin/fortran_stubs.vim
   "autocmd FileType python set omnifunc=pythoncomplete#Complete
"-------------------------------------------------------------------------------

"-------------------------------vim latex stuff---------------------------------
   " IMPORTANT: New packages are best stored in the following:
   "
   "   /opt/local/share/texmf-texlive-dist/tex/latex/
   "
   "   with a sudo command to put them threre. Once packages have been
   "   installed, then it is necessary to run texhash so that tex can find
   "   them.
   "
   "   Show all files searched by TeX: r !kpsepath tex | tr : '\n'
   "
   "   Directories with !! in front are not searched by TeX on start up
   "   (possibly because of permissions? I don't know.) This leads to the
   "   
   "
   " IMPORTANT: win32 users will need to have 'shellslash' set so that latex
   " can be called correctly.
   
   " IMPORTANT: grep will sometimes skip displaying the file name if you
   " search in a singe file. This will confuse Latex-Suite. Set your grep
   " program to always generate a file-name.
     set grepprg=grep\ -nH\ $*
   
   " OPTIONAL: This enables automatic indentation as you type.
     filetype indent on
   
   " OPTIONAL: Starting with Vim 7, the filetype of empty .tex files defaults 
   " to 'plaintex' instead of 'tex', which results in vim-latex not being 
   " loaded.
   " The following changes the default filetype back to 'tex':
     let g:tex_flavor='latex'
   " This is the folder where files are searched in vim.
   " NOTE: This is where vim will search for custom packages.
     let g:Tex_TEXINPUTS='/opt/local/texlive/2011/texmf-dist/tex/latex/'
   
   "No DVI viewer, set default output to pdf
     let g:Tex_DefaultTargetFormat ='pdf'
"-------------------------------------------------------------------------------

"Remap keys for R: now send commands with space bar!
"vmap <Space> <Plug>RdSendSelection
"nmap <Space> <Plug>RDSendLine

fun! UseConqueForThisFile()
"Conque Settings for vimR:
   let vimrplugin_ca_ck = 0
   let vimrplugin_applescript = 0
   let vimrplugin_screenplugin = 0
   let vimrplugin_conqueplugin = 1
  
"Make the windows split vertically
   "let vimrplugin_conquevsplit = 1
   let ConqueTerm_CWInsert = 1
   let ConqueTerm_Color = 0
   let ConqueTerm_ReadUnfocused = 1
"Change the waiting time to increase the chance of output being 
"show right away (bigger time = better apparently)
   let vimrplugin_conquesleep = 100
"The use of |ConqueTerm_ReadUnfocused| will set the value of 'updatetime'
"to 1000 milliseconds.
"let vimrplugin_conquesleep = 1
   nmap <F5> :call RScrollTerm()<CR>
endfun

"AppleScript syntax
au BufRead,BufNewFile *.scrp,*.as set filetype=applescript
au! Syntax applescript source ~/.vim/applescript.vim

"Cursor
highlight Cursor guifg=black guibg=orange
highlight iCursor guifg=pink guibg=orange

"--- Read text from pdf files
command! -complete=file -nargs=1 Rpdf :r !pdftotext -nopgbrk <q-args> - |fmt -csw78
"--- Edit text to latex by replacing symbols
command! Edit2Tex :so ~/.vim/vim_personal/edittotex.vim


"--- Highlight a column in csv text.
" :Csv 1    " highlight first column
" :Csv 12   " highlight twelfth column
" :Csv 0    " switch off highlight
function! CSVH(colnr)
  if a:colnr > 1
    let n = a:colnr - 1
    execute 'match Keyword /^\([^,]*,\)\{'.n.'}\zs[^,]*/'
    execute 'normal! 0'.n.'f,'
  elseif a:colnr == 1
    match Keyword /^[^,]*/
    normal! 0
  else
    match
  endif
endfunction
command! -nargs=1 Csv :call CSVH(<args>) 

"CTRL-A goes to the end of the line while typing:
   "imap <C-a> <esc>$i<right>
"CTRL-C to copy (visual mode)
"  vnomap <C-C> y
"CTRL-X to cut (visual mode)
"  vnomap <C-X> x
"CTRL-V to paste (insert mode)
"  inomap <C-V> <esc>P

"remap <Leader><Tab> to ` for easier completion in VimLaTeX
"  inoremap <Leader><Tab>  `
"
set transparency=10
