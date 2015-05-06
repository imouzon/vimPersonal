"Function: g:AddTimestamp() function 
"Adds timestamps when files are saved
"
"Args:
"timestamp_newfile: adds creation date
"
"Returns:
"1 if the no errors were encountered, 0 otherwise
function! vimPersonal#AddTimestamp(timestamp_newfile)
   if a:timestamp_newfile == 1
      execute "2," . 9 . "s/Creation Date:.*/Creation Date: " .strftime("%d-%m-%Y")
      execute "normal G"
   endif

   "Add time saved to file
   "execute "normal mp"
   execute "2," . 9 . "s/Last Modified:.*/Last Modified: " .strftime("%c")
   "execute "normal `p"
endfunction

