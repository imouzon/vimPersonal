" ============================================================================
" File:        autoload/vimPersonal.vim
" Description: Vim global plugin that provides some nice functions for Ian
" Maintainer:  Ian Mouzon <imouzon @ iastate dot edu>
" Last Change: 15 January, 2015
" License:     This program is free software. It comes without any warranty,
"              to the extent permitted by applicable law. You can redistribute
"              it and/or modify it under the terms of the Do What The Fuck You
"              Want To Public License, Version 2, as published by Sam Hocevar.
"              See http://sam.zoy.org/wtfpl/COPYING for more details.
"
" ============================================================================

"Function: ColorMe(...) function 
"Alternate between preferred light and dark themes
"
"Args:
"colorscheme ("light" or 'dark')
"
"Returns:
"1 if the no errors were encountered, 0 otherwise
function! vimPersonal#ColorMe(...)
   if a:1 == 'light'
      :colorscheme summerfruit256
   endif
   if a:1 == 'dark'
      :colorscheme wombat256mod
   endif
endfunction


"Function: g:AddHeader() function 
"Adds headers to newly created files
"
"Args:
"
"Returns:
"1 if the no errors were encountered, 0 otherwise

"Headers for R, FORTRAN, SAS, C, JAVA, LISP, TeX files
function! vimPersonal#AddHeader()
   let available_header_file_extensions = "R c cpp css f for java javascript lisp lsp rnw sas tex vim"
   "general parameters
   " directory path:      expand('%:p:h')
   " filename (with ext): expand("%:t")
   " filename (no ext):   expand("%:t:r")
   " fext = expand("%:t:e")
   
   let ftvar = expand("%:t:e")

   let header_loc = escape(expand('<sfile>:p:h'),'\') . '/headers/'

   if filereadable(expand('%:p:h:h').'/NAMESPACE')
      let ftvar = "rdev"
   else
      let ftvar = tolower(a:ftvar)
   endif

   execute 'so '.header_loc.a:ftvar."_header.vim"

   "Add file name to the header
   exe "%s/2," . 9 . "g/File Name:.*/s//File Name: " .expand("%")."/e"

   if ftvar == 'tex'
      execute "s1,2/For LaTeX-Box: root \=/For LaTeX-Box: root \= ".expand("%:r").".tex/e"

   elseif ftvar == 'rnoweb'
      let workingdir = 'working.dir = "'.expand('%:p:h').'"'
      execute "%s/#working\.dir \= \"\.\"/".workingdir."/e"
      execute "%s/#setwd(working.dir)/setwd(working.dir)/e"

   elseif ftvar == 'rmarkdown'
      let workingdir = 'working.dir = "'.expand('%:p:h').'"'
      let render = 'render("'.expand('%:p').'")'
      execute "%s/#working.dir \= '\.'/".workingdir.'/e'
      execute "%s/#setwd(working.dir)/setwd(working.dir)/e"
      execute "%s/render(pathtofile)/".render."/e"
      execute "%s/#if(FALSE)/if(FALSE)/e"

   endif

endfunction


"Function: vimPersonal#AddTimestamp() function 
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


" ============================================================================
" File:        vimpy.vim
" Description: Vim global plugin that provides some nice functions for Ian
" Maintainer:  Ian Mouzon <imouzon @ iastate dot edu>
" Last Change: 15 January, 2015
" License:     This program is free software. It comes without any warranty,
"              to the extent permitted by applicable law. 
"
" ============================================================================

function! vimPersonal#ScreenSessions(close_group)
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

" ============================================================================
" File:        CourseDir(course,....) 
" Description: Vim global plugin that provides some nice functions for Ian
" Maintainer:  Ian Mouzon <imouzon @ iastate dot edu>
" Last Change: 15 January, 2015
" License:     This program is free software. It comes without any warranty,
"              to the extent permitted by applicable law. 
"
" ============================================================================
function! vimPersonal#CourseDir(course,...)
   "let folders = ['hw','exam','text','study','notes','course']
   "let nfolders = count(folders)
   if a:0 > 0
      let rootDir = a:1
   else
      let rootDir = '~/courses/'
   endif
   if isdirectory(rootDir.a:course)
      'The directory '.a:course.' already exisits in '.rootDir.'.'
   else
      let rootDir = rootDir.a:course.'/'
      exec system('mkdir {'.rootDir.','.rootDir.'/{hw,exam,text,study,notes,course}}')
   endif
endfunction!


"------------------------------------------------------------------------------
"ssh -p 323 impact3.stat.iastate.edu -l imouzon
"R CMD BATCH filename &
"nohup R CMD BATCH filename &
"nohup nice R CMD BATCH filename &
"& = do other stuff instead
"nohup = keep working even if I logout
"nice = lower priority
"top = see people's names
"------------------------------------------------------------------------------

"impact server log in
function! vimPersonal#Impact(...)
   "impact server user name
   let user = "imouzon"

   "port
   let portNo = 323

   "which impact do I want to use
   if a:0 > 0
      let serverNo = a:1
   else
      let serverNo = 3
   end

   "shell command
   let ssh_cmd = "!ssh -p ".portNo." impact".serverNo.".stat.iastate.edu -l ".user

   "open the new blog post
   execute ssh_cmd
endfunction


"copy current file to smb folder
function! vimPersonal#CopyImpactR(...)
   "username
   let user = "imouzon"

   "smb subfolder
   let smbsubfolder = '/R/'
   
   "smb folder prefix
   let smbfolder = "/Volumes/".user.smbsubfolder
   
   "which impact do I want to use
   if a:0 > 0
      let filename = a:1
   else
      let filename = expand('%:t')
   end

   "create the final copy command:
   let CI_command = '!cp '.expand('%:p').' '.smbfolder.filename

   "run the copy command
   execute CI_command
endfunction


function! vimPersonal#SSHrunsR(Rfile,sshcmd,be_nice,be_hup,be_and)
   "p1: set up R command line
      if a:be_nice > 0
         let how_nice = 'nice'
      else
         let how_nice = ''
      end

      "turned hup for what
      if a:be_hup > 0
         let how_hup = ''
      else
         let how_hup = 'nohup'
      end

      "and ampersand
      if a:be_and > 0
         let how_and = ' &'
      else
         let how_and = ''
      end

      "
      let RCMD = ' "'.how_hup.' '.how_nice.' R CMD BATCH ./R/'.a:Rfile.how_and.'"'
   
   "p2: run the Rcode on the impact server
      "Full form of command to submit
      let sshR = a:sshcmd.RCMD

      "Run some R code
      execute sshR
endfunction

"copy R code to the terminal
function! vimPersonal#RtoSSH(...)
   "p1: copy the R code so it is available to impact
      "Copy the current R file to the impact folder
      execute CopyImpactR()

   "p2: set up variables for paths/commands
   "    user, server, rfolder
      "username
      let user = "imouzon"

      "smb folder prefix
      let smbfolder = "/Volumes/".user

      "server number
      let serverNo = 3

      "server name
      let server = 'impact'.serverNo.'.stat.iastate.edu'

      "port number
      let portNo = 323
   
      "form of the ssh command
      let sshcmd = '!ssh -p '.portNo.' '.server.' -l '.user
      
   "p3: Knowing where the Rcode is stored
   "    the Rfolder, the Rfile
   
      "R folder: where has the R code been put?
      let Rfolder = smbfolder.'/R/'

      "Rfile to run
      let Rfile = expand('%:t')

   "p4: batch submit the code
      call vimPersonal#SSHrunsR(Rfile,sshcmd,1,0,1)

   "p5: Now that the R code has run, retrieve the R output
      "files current directory
      let resultsDir = expand('%:p:h')

      "Output file extension
      let outext = '.rds'

      "create command to retrieve the R output
      let retrieveR = 'silent !mv '.Rfolder.'/*'.outext.' '.resultsDir

      "and retrieve it
      execute retrieveR
endfunction


"Function: vimPersonal#AddTimestamp() function 
"Adds timestamps when files are saved
"
"Args:
"timestamp_newfile: adds creation date
"
"Returns:
"1 if the no errors were encountered, 0 otherwise
function! vimPersonal#KnitVim(...)
   "A wrapper for several knitting options
   if a:0 ==? 0
      "by default, this function just knits the file
      !R --no-save --no-restore -e "require(knitr); knit('%:r.rnw',output='%:r.tex'); q()"
   else
      "These are the knitting options
      let knitInputs = ["knitsilent","inFileDir","compileTeX","openPDF","usingRmacros"]
      let nknitopts = len(knitInputs)

      "check each option (separatly :sadface:)

      "need to sed then compile if Rmacros used
      if index(a:000,'usingRmacros') > -1
         if index(a:000,"knitsilent") > -1
            silent !R --no-save --no-restore -e "source('~/R/R.latex.macros.r'); R.latex.macros.sed.func('%:r')"
            silent !R --no-save --no-restore -e "require(knitr); knit('%:p:r.tmp.rnw',output='%:p:r.tex'); q()"
         else
            !R --no-save --no-restore -e "source('~/R/R.latex.macros.r'); R.latex.macros.sed.func('%:r')"
            !R --no-save --no-restore -e "require(knitr); knit('%:p:r.tmp.rnw',output='%:p:r.tex'); q()"
         end
      else
         "if no Rmacros are used we skip the sed step
         if index(a:000,"knitsilent") > -1
            silent !R --no-save --no-restore -e "require(knitr); knit('%:p:r.rnw',output='%:p:r.tex'); q()"
         else
            !R --no-save --no-restore -e "require(knitr); knit('%:p:r.rnw',output='%:p:r.tex'); q()"
         end
      end

      "the knitr file has made a TeX in either way at this point
      "Now we ask if we should compile the TeX to a pdf
      if index(a:000,'compileTeX') > -1
         if index(a:000,"knitsilent") > -1
            silent !pdflatex -interaction=batchmode %:p:r.tex
         else
            !pdflatex -interaction=nonstopmode %:p:r.tex
         end
         "the TeX has been compile, should we open it?
         if index(a:000,"openPDF") > -1
            silent !open %:p:r.pdf
         end
      end
   end
   :redraw!
endfunction

function! vimPersonal#KnitDebug(...)
   !R --no-save --no-restore -e "require(knitr); knit('%:p:r.rnw',output='%:p:r.tex'); q()"
   !pdflatex %:p:r.tex
   silent !open %:p:r.pdf
   :redraw!
endfunction


"Function: vimPersonal#AddTimestamp() function 
"Adds timestamps when files are saved
"
"Args:
"timestamp_newfile: adds creation date
"
"Returns:
"1 if the no errors were encountered, 0 otherwise
"load large packages the first time the focus is lost

function! vimPersonal#LosingFocusLoadPackage(...)
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

function! vimPersonal#LosingFocus()
   if g:LosingFocus_run == 0
      "if there are no arguments and there is nothing provided 
      "only load AutoCorrect as the default
      if empty(g:LosingFocusPackages) && a:0 == 0
         let g:LosingFocusPackages = [["AutoCorrect"]]
      endif

      let lf_len = len(g:LosingFocusPackages)
      echom "Focus has been lost. The following tools have been loaded"
      for lfp_i in copy(g:LosingFocusPackages)
         call vimPersonal#LosingFocusLoadPackage(lfp_i)
      endfor
      let g:LosingFocus_run = 1
   endif
endfunction

"Function: vimPersonal#AddTimestamp() function 
"Adds timestamps when files are saved
"
"Args:
"timestamp_newfile: adds creation date
"
"Returns:
"1 if the no errors were encountered, 0 otherwise
"load large packages the first time the focus is lost

function! vimPersonal#GiveRfiletype()
   let ft = expand("%:e")
   if ft == 'c'
      GiveRC
   elseif ft == "f" || ft == "for"
      GiveRF
   else
      echom "The filetype" ft "does not compile to R"
   endif
endfunction


function! vimPersonal#MyAutoCorrect(...)
   "common latex frustrations
   ia alpha \alpha
   ia rho \rho
   
   "math misspellings
   ia kernal kernel
   ia Kernal Kernel
endfunction
