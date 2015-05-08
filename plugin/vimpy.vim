" File:        vimpy.vim
" Description: Vim global plugin that provides some nice functions for Ian
" Maintainer:  Ian Mouzon <imouzon @ iastate dot edu>
" Last Change: 15 January, 2015
" License:     This program is free software. It comes without any warranty,
"              to the extent permitted by applicable law. 
"
" ============================================================================

function! ScreenSessions(close_group)
   redir @s
   silent execute "!screen -ls"
   redir END

   let total = 0
   let screens = []
   while split(@s)[total] != 'Sockets' && split(@s)[total] != 'Socket'
      let screenchk = split(@s)[total]
      if strlen(substitute(screenchk,a:close_group,'','')) < strlen(screenchk)
         let screens = add(screens,split(@s)[total])
      endif
      let total += 1
   endwhile

   if len(screens) == 0
      echo "No screen session are open with name like ".a:close_group
      echo "Please create a session in the terminal by using:"
      echo "screen ipython"
      echo "and then changing the session name by using"
      echo "<C-a>:sessionname ".a:close_group
      execute "!open /Applications/Utilities/terminal.app"
   endif

   if len(screens) == 1
      echo "There is only one session with a name like ".a:close_group
      echo screens[0]
      echo "You are ready to edit and write python code"
   endif

   if len(screens) > 1
      let inc = 1
      while inc < len(screens)
         execute '!screen -X -S '.screens[eval(inc-1)].' quit'
         let inc += 1
      endwhile
   endif

endfunction

command! Vimpy call ScreenSessions('vimpy')

nnoremap <Leader>ip :call ScreenSessions('vimpy')<CR>
nnoremap <Leader>iq :execute '!screen -X -S vimpy quit'<CR>
