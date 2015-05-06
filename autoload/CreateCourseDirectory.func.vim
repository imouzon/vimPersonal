function! MakeDir(rootDir,fldr)
   let MDcmd = "mkdir ".a:rootDir.a:fldr
   call system(MDcmd)
endfunction!

function! CourseDir(courseNum,...)
   "let folders = ['hw','exam','text','study','notes','course']
   "let nfolders = count(folders)
   if a:0 > 0
      let rootDir = a:1
   else
      let rootDir = '~/courses/'
   endif
   if isdirectory(rootDir.a:courseNum)
      'The directory '.a:courseNum.' already exisits in '.rootDir.'.'
   else
      call MakeDir(rootDir,a:courseNum)
      let rootDir = rootDir.a:courseNum.'/'
      call MakeDir(rootDir,'hw')
      call MakeDir(rootDir,'exam')
      call MakeDir(rootDir,'text')
      call MakeDir(rootDir,'study')
      call MakeDir(rootDir,'notes')
      call MakeDir(rootDir,'course')
   endif
endfunction!

"function! NewHW(course)
"   let rootDir = '~/courses/'.a:course.'/hw/'
"   let i = 1
"   let maxHW = 15
"   while i < maxHW
"      let checkHW = 'hw'.i
"      let dirCheck = rootDir.checkHW
"      echo isdirectory(dirCheck)
"      echo dirCheck
"      if isdirectory(dirCheck) == 0
"         call MakeDir(rootDir,checkHW)
"         let i = maxHW
"      else
"         echo 'Homework '.i.' already has a folder ('.isdirectory(rootDir.checkHW).')'
"         let i = i+1
"      endif
"   endwhile
"endfunction!
      


