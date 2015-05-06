" File: update_ctags.func.vim
" Author: Me
" Description: Update ctags by finding all the .h, .c, .cpp on cpu
" Last Modified: September 21, 2013 

function! UPDATE_CTAGS()
   let _f_ = expand("%:p")
   let _cmd_ = '"ctags -a -f /dvr/tags --c++-kinds=+p --fields=+iaS --extra=+q " ' . '"' . _f_ . '"'
   let _resp = system(_cmd_)
   unlet _cmd_
   unlet _f_
   unlet _resp
endfunction
autocmd BufWritePost *.cpp,*.h,*.c call UPDATE_CTAGS()

