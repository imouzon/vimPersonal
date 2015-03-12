


"load large packages the first time the focus is lost
   let g:LosingFocus_run = 0
   function! LosingFocus()
      if g:LosingFocus_run == 0
         call AutoCorrect()
        let g:LosingFocus_run = 1
      endif
   endfunction

   au FocusLost * :call LosingFocus()

