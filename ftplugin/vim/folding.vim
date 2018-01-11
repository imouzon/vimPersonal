"setlocal foldmethod=expr
"setlocal foldexpr=GetVimscriptFold(v:lnum)
"
"function! IndentLevel(lnum)
"   return indent(a:lnum) / &shiftwidth
"endfunction
"
"function! g:NextNonBlankLine(lnum)
"   let numlines = line('$')
"   let current = a:lnum
"
"   while current <= numlines
"      if getline(current) =~? '\v\S'
"         return current
"      endif
"
"      echo 'numlines ' . current . ' is blank'
"
"      let current += 1
"   endwhile
"
"   return -2
"
"endfunction
"
"function! g:GetVimscriptFold(lnum)
"   if getline(a:lnum) =~? '\v^\s*$'
"      return '-1'
"   endif
"
"   if getline(a:lnum) =~? '"===============================================================================$'
"      let this_indent = '1'
"   endif
"
"   if this_indent == '1'
"      return '1'
"   endif
"
"   let this_indent = IndentLevel(a:lnum) + 1
"   let next_indent = IndentLevel(NextNonBlankLine(a:lnum))
"
"   if next_indent == this_indent
"      return this_indent
"   elseif next_indent < this_indent
"      return this_indent
"   elseif next_indent > this_indent
"      return '>' . next_indent
"   endif
"endfunction
