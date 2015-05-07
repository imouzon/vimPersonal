function! vimPersonal#ColorMe(...)
   if a:1 == 'light'
      :colorscheme summerfruit256
   endif
   if a:1 == 'dark'
      :colorscheme wombat256mod
   endif
endfunction
