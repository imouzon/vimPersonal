function! ShaqFu(...)
   "This function searches a string for a variable
   echom "There are ".a:0." teammates in ShaqFu"
   let coplayers = ["penny","kobe","wade","nash"]

   let ci = len(coplayers)
   let i = 0

   while i < ci
      if index(a:000,coplayers[i]) > -1
         echom "New player: ".coplayers[i]." has been unlocked"
      end
      let i += 1
   endwhile
endfunction

function! KnitVim(...)
   "A wrapper for several knitting options
   if a:0 ==? 0
      "by default, this function just knits the file
      !R --no-save --no-restore -e "require(knitr); knit('%:r.rnw',output='%:r.tex'); q()"
   else
      "These are the knitting options
      let knitInputs = ["knitsilent","inFileDir","compileTeX","openPDF","usingRmacros"]
      let nknitopts = len(knitInputs)

      "check each option (seperatly :sadface:)

      "need to sed then compile if Rmacros used
      if index(a:000,'usingRmacros') > -1
         if index(a:000,"knitsilent") > -1
            silent !sed 's/\\R{\s*\(.*\)\s*}/\\Sexpr{\1\}/g' %:p > %:p:r.tmp.rnw 
            silent !R --no-save --no-restore -e "require(knitr); knit('%:p:r.tmp.rnw',output='%:p:r.tex'); q()"
         else
            !sed 's/\\R{\s*\(.*\)\s*}/\\Sexpr{\1\}/g' %:p > %:r.tmp.rnw 
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
endfunction

command! KnitQ call KnitVim("knitsilent","compileTeX","openPDF")
command! KnitL call KnitVim("compileTeX","openPDF")
command! KnitR call KnitVim("knitsilent","usingRmacros","compileTeX","openPDF")

