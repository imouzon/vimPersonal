function! CourseDir(rootdir,course)
   let l:newdir = a:rootdir.'/'.a:course
   if isdirectory(l:newdir)
     echo 'the folder '.l:newdir.' already exists'
   else
      call mkdir(l:newdir,'p')
   endif
endfunction!
