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
