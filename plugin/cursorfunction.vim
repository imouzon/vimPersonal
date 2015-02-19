function! SetCursorStyle()
   if &term =~ ""
      "use a | cursor in insert mode
      let &t_SI = "\<Esc>]50;CursorShape=1\x7"

      "use a rectangle cursor otherwise
      let &t_EI = "\<Esc>]50;CursorShape=0\x7"

      "reset cursor when vim exits
      autocmd VimLeave * silent !echo -ne "\<Esc>]50;CursorShape=0\x7"
   elseif exists('&TMUX')
      "use a | cursor in insert mode
      let &t_SI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=1\x7\<Esc>\\"

      "use a rectangle cursor otherwise
      let &t_EI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=0\x7\<Esc>\\"

      "reset cursor when vim exits
      autocmd VimLeave * silent !echo -ne "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=0\x7\<Esc>\\"
   endif
endfunction
