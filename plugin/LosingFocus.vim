"load large packages the first time the focus is lost
let g:LosingFocus_run = 0

function! LosingFocusLoadPackage(...)
   "the argument is a list with the package name first and any arguments after
   if len(a:1) == 1 
      echo "Loading the package" a:1[0] "(no arguments)"
      execute "call ".a:1[0]."()"
   else
      let args = join(a:1[1:], ', ')
      echo "Loading the package ".a:1[0]."(".args.")"
      execute "call ".a:1[0]."(".args.")"
   endif
endfunction

function! LosingFocus()
   if g:LosingFocus_run == 0
      "if there are no arguments and there is nothing provided 
      "only load AutoCorrect as the default
      if empty(g:LosingFocusPackages) && a:0 == 0
         let g:LosingFocusPackages = [["AutoCorrect"]]
      endif

      let lf_len = len(g:LosingFocusPackages)
      echom "Focus has been lost. The following tools have been loaded"
      for lfp_i in copy(g:LosingFocusPackages)
         call LosingFocusLoadPackage(lfp_i)
      endfor
      let g:LosingFocus_run = 1
   endif
endfunction

au FocusLost * :call LosingFocus()
