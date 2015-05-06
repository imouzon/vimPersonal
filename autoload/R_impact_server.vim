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
function! Impact(...)
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

"do it from shell instead
nmap <Leader>ssh :call Impact()<CR>
nmap <Leader>ssh2 :call Impact(2)<CR>
nmap <Leader>ssh3 :call Impact(3)<CR>
nmap <Leader>ssh4 :call Impact(4)<CR>


"copy current file to smb folder
function! CopyImpactR(...)
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

function! SSHrunsR(Rfile,sshcmd,be_nice,be_hup,be_and)
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
function! RtoSSH(...)
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
      call SSHrunsR(Rfile,sshcmd,1,0,1)

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

nmap <Leader>sshR :call RtoSSH()<CR>


